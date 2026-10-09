// Favourite Song Tournament: single-elimination bracket over the
// whole catalogue. Entirely client-side — the full song list is
// embedded in the page once, and all bracket state (including
// mid-tournament progress) lives in localStorage, same as
// favorites.js, so no account and no server round-trips per pick.
(function () {
    "use strict";
    var STORAGE_KEY = "ts_tournament";
    var root = document.getElementById("tournament-root");
    if (!root || !window.TS_SONGS) {
        return;
    }

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
            totalSongs: shuffled.length,
            champion: null
        };
    }

    function readState() {
        try {
            var raw = localStorage.getItem(STORAGE_KEY);
            return raw ? JSON.parse(raw) : null;
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

        var resetBtn = document.createElement("button");
        resetBtn.type = "button";
        resetBtn.className = "tournament-reset";
        resetBtn.textContent = "Start over";
        resetBtn.addEventListener("click", startOver);
        root.appendChild(resetBtn);
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

        var resetBtn = document.createElement("button");
        resetBtn.type = "button";
        resetBtn.className = "tournament-reset";
        resetBtn.textContent = "Start a new tournament";
        resetBtn.addEventListener("click", startOver);
        root.appendChild(resetBtn);
    }

    render();
})();
