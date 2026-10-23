// Shared playlist storage — a playlist is a name plus an ordered
// array of song objects ({song_id, title, album_id, album,
// duration_seconds}). Logged out: localStorage only, nothing sent
// anywhere. Logged in: stored on the server under your account, so
// it follows you to any device — see backend/api/playlists.php.
// window.TS_LOGGED_IN (set in nav.php) picks which; every method
// here always returns a Promise (even the localStorage path, via
// Promise.resolve) so callers don't need to branch on login state
// themselves — see playlists_view.js and tournament.js.
//
// Deliberately generic (not tied to the Tournament) so any future
// way of building a playlist can reuse the same storage.
//
// Songs are removed by position, not by song_id — a playlist built
// from the Tournament can contain both "Style" and "Style (Taylor's
// Version)", which share a song_id, so song_id alone isn't unique
// enough to safely identify one entry to remove.
window.TSPlaylists = (function () {
    "use strict";
    var STORAGE_KEY = "ts_playlists";

    function readLocal() {
        try {
            var raw = localStorage.getItem(STORAGE_KEY);
            return raw ? JSON.parse(raw) : [];
        } catch (e) {
            return [];
        }
    }

    function writeLocal(list) {
        try {
            localStorage.setItem(STORAGE_KEY, JSON.stringify(list));
        } catch (e) {
            // localStorage unavailable — the playlist just won't save.
        }
    }

    function makeId() {
        return Date.now().toString(36) + "-" + Math.random().toString(36).slice(2, 8);
    }

    function apiCall(action, extra) {
        var body = { action: action, csrf_token: window.TS_CSRF_TOKEN };
        if (extra) {
            for (var key in extra) {
                if (Object.prototype.hasOwnProperty.call(extra, key)) {
                    body[key] = extra[key];
                }
            }
        }
        return fetch("api/playlists.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(body)
        }).then(function (resp) { return resp.json(); });
    }

    // Server playlists come back as {playlist_id, ...}; the rest of
    // the app (playlists_view.js, tournament.js) only knows about
    // `id`, same field name the localStorage shape already used.
    function normalize(serverPlaylists) {
        return (serverPlaylists || []).map(function (p) {
            return { id: p.playlist_id, name: p.name, songs: p.songs, source: p.source, created_at: p.created_at };
        });
    }

    var importedThisPageView = false; // avoids re-attempting the import on every readAll() in one page view

    function readAll() {
        if (!window.TS_LOGGED_IN) {
            return Promise.resolve(readLocal());
        }

        return apiCall("list").then(function (data) {
            var serverPlaylists = (data && data.ok) ? data.playlists : [];
            if (importedThisPageView || serverPlaylists.length > 0) {
                return normalize(serverPlaylists);
            }
            var localPlaylists = readLocal();
            if (localPlaylists.length === 0) {
                return normalize(serverPlaylists);
            }
            // First login on a device with pre-existing local
            // playlists, and nothing saved to this account yet — copy
            // them up once. If the account already has playlists
            // (e.g. a second device), local data here is left exactly
            // as it is and just ignored from now on.
            importedThisPageView = true;
            var payload = localPlaylists.map(function (p) {
                return {
                    name: p.name,
                    source: p.source || null,
                    song_ids: (p.songs || []).map(function (s) { return s.song_id; })
                };
            });
            return apiCall("import", { playlists: payload }).then(function (importData) {
                return normalize((importData && importData.ok) ? importData.playlists : serverPlaylists);
            });
        }).catch(function () {
            return [];
        });
    }

    function save(name, songs, source) {
        if (!window.TS_LOGGED_IN) {
            var playlist = {
                id: makeId(),
                name: name,
                songs: songs,
                source: source || null,
                created_at: new Date().toISOString()
            };
            var list = readLocal();
            list.push(playlist);
            writeLocal(list);
            return Promise.resolve();
        }

        var songIds = songs.map(function (s) { return s.song_id; });
        return apiCall("create", { name: name, source: source || null, song_ids: songIds });
    }

    function remove(playlistId) {
        if (!window.TS_LOGGED_IN) {
            writeLocal(readLocal().filter(function (p) { return p.id !== playlistId; }));
            return Promise.resolve();
        }
        return apiCall("delete", { playlist_id: playlistId });
    }

    function removeSongAt(playlistId, index) {
        if (!window.TS_LOGGED_IN) {
            var list = readLocal();
            list.forEach(function (p) {
                if (p.id === playlistId) {
                    p.songs.splice(index, 1);
                }
            });
            writeLocal(list);
            return Promise.resolve();
        }
        return apiCall("remove_song", { playlist_id: playlistId, position: index });
    }

    return { readAll: readAll, save: save, remove: remove, removeSongAt: removeSongAt };
})();
