-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- User keybinds.
-- Lua port of UserConfigs/UserKeybinds.conf
--
-- This file is required after configs/Keybinds.lua, so binds declared here can
-- override the defaults with hl.unbind() first.

local mainMod    = "SUPER"
local scriptsDir = os.getenv("HOME") .. "/.config/hypr/scripts"

-- ScreenShot.sh --freeze-area fixes dropdowns closing while capturing
hl.unbind(mainMod .. " + SHIFT + Print")
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --freeze-area"),
    { description = "screenshot freeze area (fixes dropdowns closing)" })
