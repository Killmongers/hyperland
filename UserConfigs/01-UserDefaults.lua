-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- User defaults apps.
-- Lua port of UserConfigs/01-UserDefaults.conf
--
-- This module is the single place where the default terminal / file manager /
-- editor are defined. It returns a table so other modules can require it:
--   local defaults = require("UserConfigs.01-UserDefaults")
--   hl.bind("SUPER + Return", hl.dsp.exec_cmd(defaults.term))

local defaults = {
    -- Default editor. Falls back to nvim when $EDITOR is not set.
    editor = os.getenv("EDITOR") or "nvim",

    -- Terminal
    term = "kitty",

    -- File manager
    files = "thunar",

    -- Web search engine used by scripts/RofiSearch.sh
    search_engine = "https://www.google.com/search?q={}",
}

hl.env("EDITOR", defaults.editor)

return defaults
