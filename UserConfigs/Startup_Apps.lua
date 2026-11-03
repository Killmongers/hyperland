-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- User autostart.
-- Lua port of UserConfigs/Startup_Apps.conf
-- Runs after configs/Startup_Apps.lua.
-- See https://wiki.hypr.land/configuring/core/autostart/

local home = os.getenv("HOME")

hl.on("hyprland.start", function()
    hl.exec_cmd("sleep 2 && awww img " .. home ..
        "/Pictures/wallpapers/black-panther.jpg --transition-fps 60 --transition-type grow --transition-duration 2")
end)
