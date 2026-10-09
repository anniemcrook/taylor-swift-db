// Favourite Song Tournament: double-elimination over the whole
// catalogue. Entirely client-side — the full song list is embedded
// in the page once, and all bracket state (including progress,
// undo history, and win counts) lives in localStorage, same as
// favorites.js, so no account and no server round-trips per pick.
//
// This is a *simplified* double elimination, not the traditional
// interleaved kind: the Winners Bracket runs to completion first,
// every loser along the way is collected into a pool, that pool
// runs as its own Losers Bracket, and the two bracket champions
// meet in one Grand Final. A real interleaved double-elim bracket
// (where losers-bracket rounds happen concurrently with winners-
// bracket rounds) avoids rematches more carefully, but is
// considerably harder to get right — this gives the same core
// guarantee that actually matters here (nobody is fully eliminated
// after just one loss) without that complexity.
//
// "Reject both" is available in either bracket (an explicit "I
// don't like/know either of these" — permanent, no second chance,
// which is the point) but not in the Grand Final, since both
// finalists have already proven themselves once.
(function () {
    "use strict";
    var STORAGE_KEY = "ts_tournament";
    // Bumped whenever the shape of saved state changes in a way that
    // makes an old save unsafe to resume as-is.
    var SCHEMA_VERSION = 3;
    var root = document.getElementById("tournament-root");
    if (!root || !window.TS_SONGS) {
        return;
    }

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

    // --- Sub-bracket engine: the same single-elimination machinery
    // runs both the Winners Bracket and the Losers Bracket. ---

    function buildSubBracket(entrants) {
        var shuffled = shuffle(entrants);
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
            champion: null,
            // true if every entrant in some round got rejected at
            // once, leaving nobody to carry forward — degenerate,
            // only reachable by rejecting very heavily.
            exhausted: false
        };
    }

    // Resolves the current match in `sub` with either one winner
    // (normal pick) or none (reject both), then advances the round
    // if that was the last match in it. Returns the loser(s) so the
    // caller can decide what happens to them (Winners Bracket losers
    // get a second chance in the Losers Bracket; Losers Bracket
    // losers are just gone).
    //
    // A rejected pair is NOT recorded into `sub.eliminated` — the
    // caller tracks those in `state.rejectedBoth` instead, since
    // they're ranked differently at the end. Recording them in both
    // places would count the same two songs twice in the final
    // ranking.
    function resolveMatch(sub, winner) {
        var pair = sub.queue[sub.matchIndex];
        var isReject = !winner;
        var losers = isReject ? pair.slice() : pair.filter(function (s) { return s !== winner; });

        if (winner) {
            sub.winners.push(winner);
        }
        if (!isReject) {
            losers.forEach(function (song) {
                sub.eliminated.push({ song: song, round: sub.round, label: roundLabel(sub.entrantsThisRound) });
            });
        }
        sub.matchIndex += 1;

        if (sub.matchIndex >= sub.queue.length) {
            if (sub.winners.length === 1) {
                sub.champion = sub.winners[0];
            } else if (sub.winners.length === 0) {
                sub.exhausted = true;
            } else {
                // "Reject both" can shrink a round by 2 instead of 1,
                // so the next round doesn't always start from an even
                // number — an odd one out gets a bye into the round
                // after, same as the byes a bracket starts with.
                var nextRoundPool = sub.winners.slice();
                var bye = null;
                if (nextRoundPool.length % 2 !== 0) {
                    bye = nextRoundPool.shift();
                }
                sub.round += 1;
                sub.entrantsThisRound = sub.winners.length;
                sub.queue = pairUp(nextRoundPool);
                sub.matchIndex = 0;
                sub.winners = bye ? [bye] : [];
            }
        }
        return losers;
    }

    function buildState() {
        return {
            schemaVersion: SCHEMA_VERSION,
            phase: "winners", // "winners" | "losers" | "final" | "done"
            wb: buildSubBracket(window.TS_SONGS),
            lb: null,
            lbPool: [],
            rejectedBoth: [], // songs rejected outright, never got a second chance
            wbChampion: null,
            lbChampion: null,
            champion: null,
            runnerUp: null,
            wins: {}, // recording_id -> number of matches actually won (byes/rejects don't count)
            totalSongs: window.TS_SONGS.length,
            history: [] // stack of previous snapshots, for "undo last pick"
        };
    }

    function snapshotState(s) {
        return JSON.parse(JSON.stringify({
            schemaVersion: s.schemaVersion,
            phase: s.phase,
            wb: s.wb,
            lb: s.lb,
            lbPool: s.lbPool,
            rejectedBoth: s.rejectedBoth,
            wbChampion: s.wbChampion,
            lbChampion: s.lbChampion,
            champion: s.champion,
            runnerUp: s.runnerUp,
            wins: s.wins,
            totalSongs: s.totalSongs
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
                discardedIncompatibleSave = true;
                return null;
            }
            loaded.history = loaded.history || [];
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

    var state = readState() || buildState();
    writeState(state);

    function currentSub() {
        if (state.phase === "winners") return state.wb;
        if (state.phase === "losers") return state.lb;
        return null;
    }

    // After a sub-bracket's round advances, check whether that whole
    // bracket just finished (a champion emerged, or everyone left
    // got rejected) and move the tournament to the next phase.
    function afterSubBracketMaybeFinished() {
        var sub = currentSub();
        if (!sub.champion && !sub.exhausted) {
            return; // round advanced, but this bracket isn't done yet
        }

        if (state.phase === "winners") {
            state.wbChampion = sub.champion; // may be null if exhausted
            if (state.lbPool.length === 0) {
                finalize(state.wbChampion);
            } else {
                state.lb = buildSubBracket(state.lbPool);
                state.phase = "losers";
            }
        } else if (state.phase === "losers") {
            state.lbChampion = sub.champion; // may be null if exhausted
            if (state.wbChampion && state.lbChampion) {
                state.phase = "final";
            } else {
                finalize(state.wbChampion || state.lbChampion);
            }
        }
    }

    function finalize(champion) {
        state.champion = champion; // may legitimately be null if almost everything was rejected
        state.phase = "done";
    }

    function pick(winner, opponent) {
        state.history.push(snapshotState(state));
        state.wins[winner.recording_id] = (state.wins[winner.recording_id] || 0) + 1;

        if (state.phase === "final") {
            state.champion = winner;
            state.runnerUp = opponent;
            state.phase = "done";
        } else {
            var sub = currentSub();
            var losers = resolveMatch(sub, winner);
            if (state.phase === "winners") {
                state.lbPool = state.lbPool.concat(losers); // a WB loss earns a shot in the LB
            }
            afterSubBracketMaybeFinished();
        }

        writeState(state);
        render();
    }

    function rejectBoth(a, b) {
        state.history.push(snapshotState(state));
        var sub = currentSub();
        var losers = resolveMatch(sub, null);
        state.rejectedBoth = state.rejectedBoth.concat(losers);
        afterSubBracketMaybeFinished();
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
        state = buildState();
        writeState(state);
        render();
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

    function phaseLabel() {
        if (state.phase === "winners") return "Winners Bracket";
        if (state.phase === "losers") return "Losers Bracket";
        if (state.phase === "final") return "Grand Final";
        return "";
    }

    function render() {
        root.innerHTML = "";

        if (discardedIncompatibleSave) {
            var notice = document.createElement("p");
            notice.className = "muted";
            notice.textContent = "Starting a fresh tournament: this run now uses a double-elimination "
                + "format (every song gets a second chance in a Losers Bracket before being fully "
                + "out), so an older single-elimination run couldn't be carried over.";
            root.appendChild(notice);
            discardedIncompatibleSave = false;
        }

        if (state.phase === "done") {
            renderResults();
            return;
        }

        var progress = document.createElement("p");
        progress.className = "muted";

        if (state.phase === "final") {
            progress.textContent = "Grand Final — the Winners Bracket champion vs. the Losers Bracket champion.";
            root.appendChild(progress);

            var pair = [state.wbChampion, state.lbChampion];
            renderMatchup(pair, false);
            return;
        }

        var sub = currentSub();
        progress.textContent = phaseLabel() + " · " + roundLabel(sub.entrantsThisRound) + " · match "
            + (sub.matchIndex + 1) + " of " + sub.queue.length + " this round · "
            + sub.eliminated.length + " eliminated from this bracket so far";
        root.appendChild(progress);

        renderMatchup(sub.queue[sub.matchIndex], true);
    }

    function renderMatchup(pair, allowRejectBoth) {
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

        if (allowRejectBoth) {
            var rejectBtn = document.createElement("button");
            rejectBtn.type = "button";
            rejectBtn.className = "tournament-reject-both";
            rejectBtn.textContent = "Reject both — I don't like or know either of these";
            rejectBtn.addEventListener("click", function () {
                rejectBoth(pair[0], pair[1]);
            });
            root.appendChild(rejectBtn);
        }

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

    function groupEliminatedByRound(eliminated) {
        var byRound = {};
        var order = [];
        eliminated.forEach(function (entry) {
            if (!byRound[entry.label]) {
                byRound[entry.label] = [];
                order.push(entry.label);
            }
            byRound[entry.label].push(entry.song);
        });
        order.reverse();
        return { byRound: byRound, order: order };
    }

    // Full ranking, best to worst: champion, runner-up, then every
    // Losers Bracket round (furthest first — surviving longer in
    // the LB is a real second-chance achievement), then everyone
    // rejected outright at the very bottom (an explicit "didn't
    // like either", which is a stronger negative signal than simply
    // losing a match, so they rank below even a round-1 LB loss).
    // Ties within one group reflect the knockout format itself —
    // songs that never played each other have no finer ordering.
    function rankedSongs() {
        var ranked = [];
        if (state.champion) ranked.push(state.champion);
        if (state.runnerUp) ranked.push(state.runnerUp);

        var lbEliminated = state.lb ? state.lb.eliminated : [];
        // The LB champion, if they lost the Grand Final, is already
        // counted as the runner-up above — exclude them from the LB
        // listing to avoid double-counting.
        var grouped = groupEliminatedByRound(lbEliminated);
        grouped.order.forEach(function (label) {
            grouped.byRound[label].forEach(function (song) {
                if (!state.runnerUp || song.recording_id !== state.runnerUp.recording_id) {
                    ranked.push(song);
                }
            });
        });

        ranked = ranked.concat(state.rejectedBoth);
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

    function renderSongList(songs) {
        var list = document.createElement("ul");
        list.className = "plain-list tournament-tied-songs";
        songs.forEach(function (song) {
            var li = document.createElement("li");
            var link = document.createElement("a");
            link.href = "song.php?song_id=" + encodeURIComponent(song.song_id);
            link.textContent = song.title;
            li.appendChild(link);
            list.appendChild(li);
        });
        return list;
    }

    function renderResults() {
        var heading = document.createElement("h2");
        heading.textContent = "Your favourite is...";
        root.appendChild(heading);

        var championEl = document.createElement("p");
        championEl.className = "tournament-champion";
        if (state.champion) {
            var link = document.createElement("a");
            link.href = "song.php?song_id=" + encodeURIComponent(state.champion.song_id);
            link.textContent = state.champion.title;
            championEl.appendChild(link);
        } else {
            championEl.textContent = "No clear favourite — almost everything ended up rejected. Try starting over with fewer rejections.";
        }
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

        if (state.champion) {
            renderPlaylistBuilder();
        }

        var rankingHeading = document.createElement("h3");
        rankingHeading.textContent = "How everyone else did";
        root.appendChild(rankingHeading);

        if (state.runnerUp) {
            var runnerUpHeading = document.createElement("p");
            runnerUpHeading.innerHTML = "<strong>Runner-up:</strong>";
            root.appendChild(runnerUpHeading);
            root.appendChild(renderSongList([state.runnerUp]));
        }

        var lbEliminated = state.lb ? state.lb.eliminated : [];
        var grouped = groupEliminatedByRound(lbEliminated);
        grouped.order.forEach(function (label) {
            var songs = grouped.byRound[label].filter(function (song) {
                return !state.runnerUp || song.recording_id !== state.runnerUp.recording_id;
            });
            if (songs.length === 0) return;
            var p = document.createElement("p");
            p.innerHTML = "<strong>" + label + " (Losers Bracket):</strong>";
            root.appendChild(p);
            root.appendChild(renderSongList(songs));
        });

        if (state.rejectedBoth.length > 0) {
            var rejectedHeading = document.createElement("p");
            rejectedHeading.innerHTML = "<strong>Rejected outright:</strong>";
            root.appendChild(rejectedHeading);
            root.appendChild(renderSongList(state.rejectedBoth));
        }

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
