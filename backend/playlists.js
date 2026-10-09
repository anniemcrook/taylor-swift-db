// Shared playlist storage — a playlist is just a name plus an
// ordered array of song objects ({song_id, title, album_id, album,
// duration_seconds}), saved to localStorage. No account, nothing
// sent to a server. This is deliberately generic (not tied to the
// Tournament) so any future way of building a playlist (picking
// songs by hand, say) can reuse the same storage and the same
// playlists.php viewer.
//
// Songs are removed by position, not by song_id/recording_id — a
// playlist built from the Tournament can contain both "Style" and
// "Style (Taylor's Version)", which share a song_id, so song_id
// alone isn't unique enough to safely identify one entry to remove.
window.TSPlaylists = (function () {
    "use strict";
    var STORAGE_KEY = "ts_playlists";

    function readAll() {
        try {
            var raw = localStorage.getItem(STORAGE_KEY);
            return raw ? JSON.parse(raw) : [];
        } catch (e) {
            return [];
        }
    }

    function writeAll(list) {
        try {
            localStorage.setItem(STORAGE_KEY, JSON.stringify(list));
        } catch (e) {
            // localStorage unavailable — the playlist just won't save.
        }
    }

    function makeId() {
        return Date.now().toString(36) + "-" + Math.random().toString(36).slice(2, 8);
    }

    function save(name, songs, source) {
        var list = readAll();
        var playlist = {
            id: makeId(),
            name: name,
            songs: songs,
            source: source || null, // e.g. "tournament" — just for display, not load-bearing
            created_at: new Date().toISOString()
        };
        list.push(playlist);
        writeAll(list);
        return playlist;
    }

    function remove(playlistId) {
        writeAll(readAll().filter(function (p) { return p.id !== playlistId; }));
    }

    function removeSongAt(playlistId, index) {
        var list = readAll();
        list.forEach(function (p) {
            if (p.id === playlistId) {
                p.songs.splice(index, 1);
            }
        });
        writeAll(list);
    }

    return { readAll: readAll, save: save, remove: remove, removeSongAt: removeSongAt };
})();
