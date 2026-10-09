// Favourite Song Tournament: single-elimination bracket over the
// whole catalogue. Entirely client-side — the full song list is
// embedded in the page once, and all bracket state (including
// mid-tournament progress, undo history, and win counts) lives in
// localStorage, same as favorites.js, so no account and no server
// round-trips per pick.
(function () {
    "use strict";
    var STORAGE_KEY = "ts_tournament";
    // Bumped when the shape of a tournament entity changes (e.g.
    // moving from one entity per song to one per recording) — an
    // old save under the previous shape gets discarded rather than
    // rendered with mismatched/missing fields.
    var SCHEMA_VERSION = 2;
    var root = document.getElementById("tournament-root");
    if (!root || !window.TS_SONGS) {
        return;
    }

    // Keyed by recording_id, not song_id — the original and the
    // Taylor's Version of the same song are different entities here
    // and need their own album lookup (even though today they'd
    // resolve to the same album either way, this keeps the lookup
    // keyed the same way as everything else in this file).
    var albumByRecordingId = {};
    window.TS_SONGS.forEach(function (s) {
        albumByRecordingId[s.recording_id] = s.album;
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
            schemaVersion: SCHEMA_VERSION,
            round: 1,
            entrantsThisRound: size,
            queue: pairUp(playing),
            matchIndex: 0,
            winners: byes.slice(),
            eliminated: [], // { song, round, label }
            wins: {}, // recording_id -> number of matches actually won (byes don't count)
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
            schemaVersion: s.schemaVersion,
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

    var discardedIncompatibleSave = false;

    function readState() {
        try {
            var raw = localStorage.getItem(STORAGE_KEY);
            if (!raw) {
                return null;
            }
            var loaded = JSON.parse(raw);
            if (loaded.schemaVersion !== SCHEMA_VERSION) {
                // A save from before entities were one-per-recording
                // (rather than one-per-song) — its song/queue/winners
                // objects don't have the fields this version expects,
                // so there's no safe way to resume it.
                discardedIncompatibleSave = true;
                return null;
            }
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

        state.wins[winner.recording_id] = (state.wins[winner.recording_id] || 0) + 1;
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

        if (discardedIncompatibleSave) {
            var notice = document.createElement("p");
            notice.className = "muted";
            notice.textContent = "Starting a fresh tournament: the original and Taylor's Version "
                + "(and any other alternate recording) of a song now count as separate entries, "
                + "so an older in-progress or finished run couldn't be carried over.";
            root.appendChild(notice);
            discardedIncompatibleSave = false;
        }

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
        Object.keys(albumByRecordingId).forEach(function (recordingId) {
            var album = albumByRecordingId[recordingId] || "Unknown";
            totals[album] = totals[album] || 0;
        });
        Object.keys(state.wins).forEach(function (recordingId) {
            var album = albumByRecordingId[recordingId] || "Unknown";
            totals[album] = (totals[album] || 0) + state.wins[recordingId];
        });
        var rows = Object.keys(totals).map(function (album) {
            return { album: album, wins: totals[album] };
        });
        rows.sort(function (a, b) {
            return b.wins - a.wins || a.album.localeCompare(b.album);
        });
        return rows;
    }

    // Groups eliminated songs by the round they fell in, furthest
    // (most recent) first — shared by the "how everyone else did"
    // display and the playlist generator below, so both agree on
    // the same ranking.
    function groupEliminatedByRound() {
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
        return { byRound: byRound, order: order };
    }

    // Full ranking as a flat array, champion first, down to the
    // round 1 losers last. Songs eliminated in the same round are
    // genuinely tied in a knockout bracket (they never played each
    // other), so there's no finer ordering between them — ties keep
    // whatever order they happened to resolve in.
    function rankedSongs() {
        var grouped = groupEliminatedByRound();
        var ranked = [state.champion];
        grouped.order.forEach(function (label) {
            grouped.byRound[label].forEach(function (song) {
                ranked.push(song);
            });
        });
        return ranked;
    }

    function formatDuration(song) {
        if (!song.duration_seconds) {
            return "";
        }
        var m = Math.floor(song.duration_seconds / 60);
        var s = song.duration_seconds % 60;
        return m + ":" + (s < 10 ? "0" : "") + s;
    }

    function renderPlaylistBuilder() {
        var section = document.createElement("div");
        section.className = "tournament-playlist-builder";

        var heading = document.createElement("h3");
        heading.textContent = "Make a playlist from these results";
        section.appendChild(heading);

        var ranked = rankedSongs();

        var form = document.createElement("div");
        form.className = "playlist-length-form";

        var label = document.createElement("label");
        label.textContent = "Playlist length: ";
        var lengthInput = document.createElement("input");
        lengthInput.type = "number";
        lengthInput.min = "1";
        lengthInput.max = String(ranked.length);
        lengthInput.value = String(Math.min(20, ranked.length));
        label.appendChild(lengthInput);
        form.appendChild(label);

        var generateBtn = document.createElement("button");
        generateBtn.type = "button";
        generateBtn.className = "tournament-reset";
        generateBtn.textContent = "Generate";
        form.appendChild(generateBtn);
        section.appendChild(form);

        var output = document.createElement("div");
        output.className = "playlist-output";
        section.appendChild(output);

        generateBtn.addEventListener("click", function () {
            var n = parseInt(lengthInput.value, 10);
            if (!n || n < 1) n = 1;
            if (n > ranked.length) n = ranked.length;
            renderGeneratedPlaylist(output, ranked.slice(0, n));
        });

        root.appendChild(section);
    }

    function renderGeneratedPlaylist(output, songs) {
        output.innerHTML = "";

        var list = document.createElement("ol");
        list.className = "plain-list";
        songs.forEach(function (song) {
            var li = document.createElement("li");
            var link = document.createElement("a");
            link.href = "song.php?song_id=" + encodeURIComponent(song.song_id);
            var strong = document.createElement("strong");
            strong.textContent = song.title;
            link.appendChild(strong);
            li.appendChild(link);
            if (song.album) {
                li.appendChild(document.createTextNode(" — " + song.album));
            }
            var duration = formatDuration(song);
            if (duration) {
                li.appendChild(document.createTextNode(" · " + duration));
            }
            list.appendChild(li);
        });
        output.appendChild(list);

        var saveForm = document.createElement("div");
        saveForm.className = "playlist-save-form";
        var nameInput = document.createElement("input");
        nameInput.type = "text";
        nameInput.placeholder = "Name this playlist";
        nameInput.setAttribute("aria-label", "Playlist name");
        saveForm.appendChild(nameInput);

        var saveBtn = document.createElement("button");
        saveBtn.type = "button";
        saveBtn.className = "tournament-reset";
        saveBtn.textContent = "Save playlist";
        saveForm.appendChild(saveBtn);
        output.appendChild(saveForm);

        var confirmation = document.createElement("p");
        confirmation.className = "muted";
        confirmation.hidden = true;
        output.appendChild(confirmation);

        saveBtn.addEventListener("click", function () {
            var name = nameInput.value.trim() || "My Tournament Playlist";
            if (!window.TSPlaylists) {
                return;
            }
            window.TSPlaylists.save(name, songs, "tournament");
            confirmation.hidden = false;
            confirmation.innerHTML = "Saved. <a href=\"playlists.php\">View your playlists</a>.";
        });
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

        renderPlaylistBuilder();

        var grouped = groupEliminatedByRound();
        var byRound = grouped.byRound;
        var order = grouped.order;

        var rankingHeading = document.createElement("h3");
        rankingHeading.textContent = "How everyone else did";
        root.appendChild(rankingHeading);

        var list = document.createElement("ol");
        list.className = "plain-list";
        order.forEach(function (label) {
            var li = document.createElement("li");
            var strong = document.createElement("strong");
            strong.textContent = label === "Final" ? "Runner-up" : label;
            li.appendChild(strong);

            // One song per line rather than a comma-joined string —
            // several titles contain commas themselves (e.g. "So
            // Long, London"), which makes a joined list genuinely
            // ambiguous to read, not just untidy.
            var songList = document.createElement("ul");
            songList.className = "plain-list tournament-tied-songs";
            byRound[label].forEach(function (song) {
                var songLi = document.createElement("li");
                var songLink = document.createElement("a");
                songLink.href = "song.php?song_id=" + encodeURIComponent(song.song_id);
                songLink.textContent = song.title;
                songLi.appendChild(songLink);
                songList.appendChild(songLi);
            });
            li.appendChild(songList);
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
