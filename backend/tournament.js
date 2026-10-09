// Favourite Song Tournament: single-elimination bracket over the
// whole catalogue. Entirely client-side — the full song list is
// embedded in the page once, and all bracket state (including
// mid-tournament progress, undo history, and win counts) lives in
// localStorage, same as favorites.js, so no account and no server
// round-trips per pick.
(function () {
    "use strict";
    var STORAGE_KEY = "ts_tournament";
    var root = document.getElementById("tournament-root");
    if (!root || !window.TS_SONGS) {
        return;
    }

    var albumBySongId = {};
    window.TS_SONGS.forEach(function (s) {
        albumBySongId[s.song_id] = s.album;
    });

    function shuffle(array) {
        var arr = array.slice();
        for (var i = arr.length - 1; i > 0; i--) {
            var j = Math.floor(Math.random() * (i + 1));
            var tmp = arr[i];
            arr[i] = arr[j];
            arr[j] = tmp;
        }
        return arr;
    }

    function nextPowerOfTwo(n) {
        var p = 1;
        while (p < n) {
            p *= 2;
        }
        return p;
    }

    function roundLabel(entrants) {
        if (entrants === 2) return "Final";
        if (entrants === 4) return "Semifinals";
        if (entrants === 8) return "Quarterfinals";
        return "Round of " + entrants;
    }

    function pairUp(list) {
        var pairs = [];
        for (var i = 0; i < list.length; i += 2) {
            pairs.push([list[i], list[i + 1]]);
        }
        return pairs;
    }

    function buildBracket(songs) {
        var shuffled = shuffle(songs);
        var size = nextPowerOfTwo(shuffled.length);
        var byeCount = size - shuffled.length;
        var byes = shuffled.slice(0, byeCount);
        var playing = shuffled.slice(byeCount);
        return {
            round: 1,
            entrantsThisRound: size,
            queue: pairUp(playing),
            matchIndex: 0,
            winners: byes.slice(),
            eliminated: [], // { song, round, label }
            wins: {}, // song_id -> number of matches actually won (byes don't count)
            totalSongs: shuffled.length,
            champion: null,
            history: [] // stack of previous snapshots, for "undo last pick"
        };
    }

    // A snapshot of everything except `history` itself — pushing
    // the live history array into its own entries would nest
    // forever, so each snapshot only needs to restore the other
    // fields and keeps sharing the same (shorter) history array.
    function snapshotState(s) {
        return JSON.parse(JSON.stringify({
            round: s.round,
            entrantsThisRound: s.entrantsThisRound,
            queue: s.queue,
            matchIndex: s.matchIndex,
            winners: s.winners,
            eliminated: s.eliminated,
            wins: s.wins,
            totalSongs: s.totalSongs,
            champion: s.champion
        }));
    }

    function readState() {
        try {
            var raw = localStorage.getItem(STORAGE_KEY);
            if (!raw) {
                return null;
            }
            var loaded = JSON.parse(raw);
            // Backward compatible with tournaments started before
            // undo/win-tracking existed — picks made before now just
            // won't be undoable or counted in the per-album stats.
            loaded.history = loaded.history || [];
            loaded.wins = loaded.wins || {};
            return loaded;
        } catch (e) {
            return null;
        }
    }

    function writeState(state) {
        try {
            localStorage.setItem(STORAGE_KEY, JSON.stringify(state));
        } catch (e) {
            // localStorage unavailable — progress just won't persist.
        }
    }

    function clearState() {
        try {
            localStorage.removeItem(STORAGE_KEY);
        } catch (e) {
            // ignore
        }
    }

    var state = readState() || buildBracket(window.TS_SONGS);
    writeState(state);

    function pick(winner, loser) {
        state.history.push(snapshotState(state));

        state.wins[winner.song_id] = (state.wins[winner.song_id] || 0) + 1;
        state.winners.push(winner);
        state.eliminated.push({ song: loser, round: state.round, label: roundLabel(state.entrantsThisRound) });
        state.matchIndex += 1;

        if (state.matchIndex >= state.queue.length) {
            if (state.winners.length === 1) {
                state.champion = state.winners[0];
            } else {
                state.round += 1;
                state.entrantsThisRound = state.winners.length;
                state.queue = pairUp(state.winners);
                state.matchIndex = 0;
                state.winners = [];
            }
        }
        writeState(state);
        render();
    }

    function undo() {
        if (state.history.length === 0) {
            return;
        }
        var previous = state.history.pop();
        var remainingHistory = state.history;
        state = previous;
        state.history = remainingHistory;
        writeState(state);
        render();
    }

    function startOver() {
        if (!window.confirm("Start a new tournament? Your current progress will be lost.")) {
            return;
        }
        clearState();
        state = buildBracket(window.TS_SONGS);
        writeState(state);
        render();
    }

    function totalPicksSoFar() {
        return state.eliminated.length;
    }

    function totalPicksNeeded() {
        return state.totalSongs - 1;
    }

    function makeUndoButton() {
        var undoBtn = document.createElement("button");
        undoBtn.type = "button";
        undoBtn.className = "tournament-reset";
        undoBtn.textContent = "Undo last pick";
        undoBtn.disabled = state.history.length === 0;
        undoBtn.addEventListener("click", undo);
        return undoBtn;
    }

    function render() {
        root.innerHTML = "";

        if (state.champion) {
            renderResults();
            return;
        }

        var progress = document.createElement("p");
        progress.className = "muted";
        progress.textContent = roundLabel(state.entrantsThisRound) + " · match "
            + (state.matchIndex + 1) + " of " + state.queue.length + " this round · "
            + totalPicksSoFar() + " of " + totalPicksNeeded() + " picks made overall";
        root.appendChild(progress);

        var pair = state.queue[state.matchIndex];
        var matchup = document.createElement("div");
        matchup.className = "tournament-matchup";

        var buttonA = makeCard(pair[0], pair[1]);
        var vs = document.createElement("span");
        vs.className = "tournament-vs";
        vs.textContent = "vs";
        var buttonB = makeCard(pair[1], pair[0]);

        matchup.appendChild(buttonA);
        matchup.appendChild(vs);
        matchup.appendChild(buttonB);
        root.appendChild(matchup);

        var actions = document.createElement("div");
        actions.className = "tournament-actions";
        actions.appendChild(makeUndoButton());
        var resetBtn = document.createElement("button");
        resetBtn.type = "button";
        resetBtn.className = "tournament-reset";
        resetBtn.textContent = "Start over";
        resetBtn.addEventListener("click", startOver);
        actions.appendChild(resetBtn);
        root.appendChild(actions);
    }

    function makeCard(song, opponent) {
        var button = document.createElement("button");
        button.type = "button";
        button.className = "tournament-card";
        var title = document.createElement("span");
        title.className = "tournament-card-title";
        title.textContent = song.title;
        button.appendChild(title);
        button.addEventListener("click", function () {
            pick(song, opponent);
        });
        return button;
    }

    function albumWinStats() {
        // Every album that has a song in the tournament starts at 0,
        // so an album whose songs lost every single match they
        // played still shows up (as the genuine "fewest winners"
        // answer) instead of being left out entirely.
        var totals = {};
        Object.keys(albumBySongId).forEach(function (songId) {
            var album = albumBySongId[songId] || "Unknown";
            totals[album] = totals[album] || 0;
        });
        Object.keys(state.wins).forEach(function (songId) {
            var album = albumBySongId[songId] || "Unknown";
            totals[album] = (totals[album] || 0) + state.wins[songId];
        });
        var rows = Object.keys(totals).map(function (album) {
            return { album: album, wins: totals[album] };
        });
        rows.sort(function (a, b) {
            return b.wins - a.wins || a.album.localeCompare(b.album);
        });
        return rows;
    }

    function renderResults() {
        var heading = document.createElement("h2");
        heading.textContent = "Your favourite is...";
        root.appendChild(heading);

        var championEl = document.createElement("p");
        championEl.className = "tournament-champion";
        var link = document.createElement("a");
        link.href = "song.php?song_id=" + encodeURIComponent(state.champion.song_id);
        link.textContent = state.champion.title;
        championEl.appendChild(link);
        root.appendChild(championEl);

        var actions = document.createElement("div");
        actions.className = "tournament-actions";
        actions.appendChild(makeUndoButton());
        var resetBtn = document.createElement("button");
        resetBtn.type = "button";
        resetBtn.className = "tournament-reset";
        resetBtn.textContent = "Start a new tournament";
        resetBtn.addEventListener("click", startOver);
        actions.appendChild(resetBtn);
        root.appendChild(actions);

        // Group eliminated songs by the round they fell in, most
        // recent (furthest they got) first.
        var byRound = {};
        var order = [];
        state.eliminated.forEach(function (entry) {
            if (!byRound[entry.label]) {
                byRound[entry.label] = [];
                order.push(entry.label);
            }
            byRound[entry.label].push(entry.song);
        });
        order.reverse();

        var rankingHeading = document.createElement("h3");
        rankingHeading.textContent = "How everyone else did";
        root.appendChild(rankingHeading);

        var list = document.createElement("ol");
        list.className = "plain-list";
        order.forEach(function (label) {
            var li = document.createElement("li");
            var strong = document.createElement("strong");
            strong.textContent = label === "Final" ? "Runner-up: " : label + ": ";
            li.appendChild(strong);
            li.appendChild(document.createTextNode(
                byRound[label].map(function (s) { return s.title; }).join(", ")
            ));
            list.appendChild(li);
        });
        root.appendChild(list);

        var albumRows = albumWinStats();
        if (albumRows.length > 0) {
            var statsHeading = document.createElement("h3");
            statsHeading.textContent = "By album";
            root.appendChild(statsHeading);

            var summary = document.createElement("p");
            summary.className = "muted";
            summary.textContent = "Most winners: " + albumRows[0].album + " (" + albumRows[0].wins + ")"
                + " · Fewest: " + albumRows[albumRows.length - 1].album
                + " (" + albumRows[albumRows.length - 1].wins + ")";
            root.appendChild(summary);

            var albumList = document.createElement("ol");
            albumList.className = "plain-list";
            albumRows.forEach(function (row) {
                var li = document.createElement("li");
                li.textContent = row.album + " — " + row.wins + " win" + (row.wins === 1 ? "" : "s");
                albumList.appendChild(li);
            });
            root.appendChild(albumList);
        }
    }

    render();
})();
