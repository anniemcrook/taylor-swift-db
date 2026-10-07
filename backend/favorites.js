// Favourites: stored entirely in the browser (localStorage), no
// account or server involved. Key is song_id (as a string) mapped
// to the song's title, so the Favourites page can render without
// needing to ask the server for anything.
(function () {
    "use strict";
    var STORAGE_KEY = "ts_favourites";

    function readFavourites() {
        try {
            var raw = localStorage.getItem(STORAGE_KEY);
            return raw ? JSON.parse(raw) : {};
        } catch (e) {
            return {};
        }
    }

    function writeFavourites(favourites) {
        try {
            localStorage.setItem(STORAGE_KEY, JSON.stringify(favourites));
        } catch (e) {
            // localStorage unavailable (private browsing, blocked, full) — ignore.
        }
    }

    function isFavourite(songId) {
        return Object.prototype.hasOwnProperty.call(readFavourites(), String(songId));
    }

    function toggleFavourite(songId, title) {
        var favourites = readFavourites();
        var key = String(songId);
        var nowFavourited;
        if (Object.prototype.hasOwnProperty.call(favourites, key)) {
            delete favourites[key];
            nowFavourited = false;
        } else {
            favourites[key] = title;
            nowFavourited = true;
        }
        writeFavourites(favourites);
        return nowFavourited;
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
            var songId = button.getAttribute("data-song-id");
            var title = button.getAttribute("data-song-title") || "";
            setButtonState(button, isFavourite(songId));
            button.addEventListener("click", function () {
                var nowFavourited = toggleFavourite(songId, title);
                // Every button for this song (it can appear more than
                // once on one page, e.g. search results) stays in sync.
                document.querySelectorAll('.favourite-toggle[data-song-id="' + songId + '"]').forEach(function (btn) {
                    setButtonState(btn, nowFavourited);
                });
                renderFavouritesList();
            });
        });
    }

    function renderFavouritesList() {
        var list = document.getElementById("favourites-list");
        if (!list) {
            return;
        }
        var empty = document.getElementById("favourites-empty");
        var favourites = readFavourites();
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
                toggleFavourite(id, favourites[id]);
                renderFavouritesList();
            });

            li.appendChild(link);
            li.appendChild(document.createTextNode(" "));
            li.appendChild(removeBtn);
            list.appendChild(li);
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        initToggleButtons();
        renderFavouritesList();
    });
})();
