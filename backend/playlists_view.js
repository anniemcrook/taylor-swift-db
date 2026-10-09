// Renders saved playlists on playlists.php. Storage itself lives in
// playlists.js (window.TSPlaylists) so it can be reused by anything
// else that creates playlists later — this file is just the view.
(function () {
    "use strict";
    var root = document.getElementById("playlists-root");
    var empty = document.getElementById("playlists-empty");
    if (!root || !window.TSPlaylists) {
        return;
    }

    function formatDuration(song) {
        if (!song.duration_seconds) {
            return "";
        }
        var m = Math.floor(song.duration_seconds / 60);
        var s = song.duration_seconds % 60;
        return m + ":" + (s < 10 ? "0" : "") + s;
    }

    function render() {
        root.innerHTML = "";
        var playlists = window.TSPlaylists.readAll();

        if (empty) {
            empty.hidden = playlists.length !== 0;
        }

        // Newest first.
        playlists = playlists.slice().reverse();

        playlists.forEach(function (playlist) {
            var card = document.createElement("div");
            card.className = "playlist-card";

            var header = document.createElement("div");
            header.className = "playlist-card-header";

            var title = document.createElement("h2");
            title.textContent = playlist.name;
            header.appendChild(title);

            var deleteBtn = document.createElement("button");
            deleteBtn.type = "button";
            deleteBtn.className = "tournament-reset";
            deleteBtn.textContent = "Delete playlist";
            deleteBtn.addEventListener("click", function () {
                if (!window.confirm('Delete the playlist "' + playlist.name + '"?')) {
                    return;
                }
                window.TSPlaylists.remove(playlist.id);
                render();
            });
            header.appendChild(deleteBtn);
            card.appendChild(header);

            var meta = document.createElement("p");
            meta.className = "muted";
            var sourceNote = playlist.source === "tournament" ? "from the Tournament · " : "";
            meta.textContent = sourceNote + playlist.songs.length + " song" + (playlist.songs.length === 1 ? "" : "s");
            card.appendChild(meta);

            var list = document.createElement("ol");
            list.className = "plain-list";
            playlist.songs.forEach(function (song) {
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

                var removeBtn = document.createElement("button");
                removeBtn.type = "button";
                removeBtn.className = "favourite-toggle";
                removeBtn.textContent = "✕";
                removeBtn.setAttribute("aria-label", "Remove " + song.title + " from this playlist");
                removeBtn.addEventListener("click", function () {
                    window.TSPlaylists.removeSong(playlist.id, song.song_id);
                    render();
                });
                li.appendChild(document.createTextNode(" "));
                li.appendChild(removeBtn);

                list.appendChild(li);
            });
            card.appendChild(list);

            root.appendChild(card);
        });
    }

    render();
})();
