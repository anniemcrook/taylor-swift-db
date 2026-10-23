// Favourites. Logged out: stored entirely in the browser
// (localStorage), no server involved — key is song_id (as a string)
// mapped to the song's title. Logged in: stored on the server under
// your account instead, so it follows you to any device — see
// backend/api/favourites.php. window.TS_LOGGED_IN (set in nav.php)
// decides which of the two this file uses; callers (initToggleButtons,
// renderFavouritesList) don't need to know or care which.
(function () {
    "use strict";
    var STORAGE_KEY = "ts_favourites";

    function readLocal() {
        try {
            var raw = localStorage.getItem(STORAGE_KEY);
            return raw ? JSON.parse(raw) : {};
        } catch (e) {
            return {};
        }
    }

    function writeLocal(favourites) {
        try {
            localStorage.setItem(STORAGE_KEY, JSON.stringify(favourites));
        } catch (e) {
            // localStorage unavailable (private browsing, blocked, full) — ignore.
        }
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
        return fetch("api/favourites.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(body)
        }).then(function (resp) { return resp.json(); });
    }

    // In-memory copy of the current favourites, loaded once (`load()`)
    // and kept in sync by every toggle after that.
    var favourites = {};
    var ready = null; // Promise resolving once `favourites` holds real data

    function load() {
        if (ready) {
            return ready;
        }
        if (!window.TS_LOGGED_IN) {
            favourites = readLocal();
            ready = Promise.resolve(favourites);
            return ready;
        }

        ready = apiCall("list").then(function (data) {
            favourites = (data && data.ok) ? data.favourites : {};
            var localIds = Object.keys(readLocal());
            // First login on a device with pre-existing local
            // favourites, and nothing saved to this account yet —
            // copy them up once. If the account already has
            // favourites (e.g. you're on a second device), local
            // data here is left exactly as it is and just ignored
            // from now on.
            if (localIds.length > 0 && Object.keys(favourites).length === 0) {
                return apiCall("import", { song_ids: localIds }).then(function () {
                    return apiCall("list");
                }).then(function (data2) {
                    favourites = (data2 && data2.ok) ? data2.favourites : {};
                    return favourites;
                });
            }
            return favourites;
        }).catch(function () {
            favourites = {};
            return favourites;
        });
        return ready;
    }

    function isFavourite(songId) {
        return Object.prototype.hasOwnProperty.call(favourites, String(songId));
    }

    function toggleFavourite(songId, title) {
        var key = String(songId);
        var nowFavourited = !Object.prototype.hasOwnProperty.call(favourites, key);

        // Optimistic: update the in-memory copy immediately so the
        // UI feels instant, then persist; roll back if that fails.
        if (nowFavourited) {
            favourites[key] = title;
        } else {
            delete favourites[key];
        }

        if (!window.TS_LOGGED_IN) {
            writeLocal(favourites);
            return Promise.resolve(nowFavourited);
        }

        var action = nowFavourited ? "add" : "remove";
        function rollBack() {
            if (nowFavourited) {
                delete favourites[key];
            } else {
                favourites[key] = title;
            }
            return !nowFavourited;
        }
        return apiCall(action, { song_id: Number(songId) }).then(function (data) {
            return (data && data.ok) ? nowFavourited : rollBack();
        }).catch(rollBack);
    }

    function setButtonState(button, favourited) {
        var title = button.getAttribute("data-song-title") || "this song";
        button.setAttribute("aria-pressed", favourited ? "true" : "false");
        button.textContent = favourited ? "★" : "☆";
        button.setAttribute(
            "aria-label",
            (favourited ? "Remove " : "Add ") + title + (favourited ? " from favourites" : " to favourites")
        );
    }

    function initToggleButtons() {
        var buttons = document.querySelectorAll(".favourite-toggle");
        buttons.forEach(function (button) {
            // Disabled until load() resolves, so a click can't race
            // ahead of the data it needs to toggle correctly.
            button.disabled = true;
            var songId = button.getAttribute("data-song-id");
            var title = button.getAttribute("data-song-title") || "";
            button.addEventListener("click", function () {
                toggleFavourite(songId, title).then(function (nowFavourited) {
                    document.querySelectorAll('.favourite-toggle[data-song-id="' + songId + '"]').forEach(function (btn) {
                        setButtonState(btn, nowFavourited);
                    });
                    renderFavouritesList();
                });
            });
        });
        load().then(function () {
            buttons.forEach(function (button) {
                var songId = button.getAttribute("data-song-id");
                setButtonState(button, isFavourite(songId));
                button.disabled = false;
            });
        });
    }

    function renderFavouritesList() {
        var list = document.getElementById("favourites-list");
        if (!list) {
            return;
        }
        var empty = document.getElementById("favourites-empty");
        var ids = Object.keys(favourites);

        list.innerHTML = "";
        if (empty) {
            empty.hidden = ids.length !== 0;
        }

        ids.sort(function (a, b) {
            return favourites[a].localeCompare(favourites[b]);
        });

        ids.forEach(function (id) {
            var li = document.createElement("li");

            var link = document.createElement("a");
            link.href = "song.php?song_id=" + encodeURIComponent(id);
            var strong = document.createElement("strong");
            strong.textContent = favourites[id];
            link.appendChild(strong);

            var removeBtn = document.createElement("button");
            removeBtn.type = "button";
            removeBtn.className = "favourite-toggle";
            removeBtn.setAttribute("data-song-id", id);
            removeBtn.setAttribute("data-song-title", favourites[id]);
            setButtonState(removeBtn, true);
            removeBtn.addEventListener("click", function () {
                toggleFavourite(id, favourites[id]).then(renderFavouritesList);
            });

            li.appendChild(link);
            li.appendChild(document.createTextNode(" "));
            li.appendChild(removeBtn);
            list.appendChild(li);
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        initToggleButtons();
        load().then(renderFavouritesList);
    });
})();
