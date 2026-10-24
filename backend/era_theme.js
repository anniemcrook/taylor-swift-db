// Lets a visitor match the site's accent colour and display font to
// a chosen era, using the same per-era colour map that powers the
// homepage era cards (window.TS_ERA_THEMES, set in nav.php from
// backend/helpers.php's era_theme_options()). A cosmetic, per-browser
// preference — saved to localStorage, never sent to the server,
// same treatment as Favourites get when logged out.
(function () {
    "use strict";
    var STORAGE_KEY = "ts_era_theme";
    var root = document.documentElement;
    var loadedFonts = {};

    function loadFont(googleParam) {
        if (!googleParam || loadedFonts[googleParam]) {
            return;
        }
        loadedFonts[googleParam] = true;
        var link = document.createElement("link");
        link.rel = "stylesheet";
        link.href = "https://fonts.googleapis.com/css2?family=" + googleParam + "&display=swap";
        document.head.appendChild(link);
    }

    function applyTheme(eraName) {
        var themes = window.TS_ERA_THEMES || {};
        var theme = themes[eraName];
        if (!theme) {
            root.style.removeProperty("--accent");
            root.style.removeProperty("--accent-hover");
            root.style.removeProperty("--font-display");
            return;
        }
        loadFont(theme.google);
        root.style.setProperty("--accent", theme.accent);
        root.style.setProperty("--accent-hover", "color-mix(in srgb, " + theme.accent + " 80%, black)");
        root.style.setProperty("--font-display", '"' + theme.font + '", Georgia, serif');
    }

    function readSaved() {
        try {
            return localStorage.getItem(STORAGE_KEY) || "";
        } catch (e) {
            return "";
        }
    }

    function writeSaved(eraName) {
        try {
            localStorage.setItem(STORAGE_KEY, eraName);
        } catch (e) {
            // localStorage unavailable — the theme just won't persist.
        }
    }

    // This <script> tag is deliberately not deferred and sits right
    // after the header markup in nav.php (near the top of <body>,
    // before <main>'s content), so a saved theme applies before most
    // of the page has rendered instead of flashing the default theme
    // first — and the #era-theme-picker element it wires up already
    // exists by the time this runs, since it's part of that same
    // already-parsed header markup.
    var saved = readSaved();
    if (saved) {
        applyTheme(saved);
    }

    var picker = document.getElementById("era-theme-picker");
    if (picker) {
        picker.value = saved;
        picker.addEventListener("change", function () {
            writeSaved(picker.value);
            applyTheme(picker.value);
        });
    }
})();
