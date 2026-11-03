-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Autostart (defaults).
-- Lua port of configs/Startup_Apps.conf
-- See https://wiki.hypr.land/configuring/core/autostart/

local home        = os.getenv("HOME")
local scriptsDir  = home .. "/.config/hypr/scripts"
local userScripts = home .. "/.config/hypr/UserScripts"

local lock       = scriptsDir .. "/LockScreen.sh"
local swwwRandom = userScripts .. "/WallpaperAutoChange.sh" -- random wallpaper on interval
local liveWall   = ""                                       -- live wallpaper command
local wallDir    = home .. "/Pictures/wallpapers"           -- change path here if needed

hl.on("hyprland.start", function()
    -- Wallpaper daemon
    hl.exec_cmd("awww-daemon --format xrgb")

    -- Export the Wayland session to systemd / dbus-activated services
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Bars, panels and applets
    hl.exec_cmd("pkill -x waybar || true; waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("qs -c overview") -- Quickshell overview
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("nm-tray")
    hl.exec_cmd("blueman-applet")

    -- Dropdown terminal
    hl.exec_cmd(scriptsDir .. "/Dropterminal.sh kitty")

    -- Polkit agent, idle daemon and night light
    hl.exec_cmd(scriptsDir .. "/Polkit.sh")
    hl.exec_cmd("hypridle")
    hl.exec_cmd(scriptsDir .. "/Hyprsunset.sh init")

    -- Clipboard history
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Layout aware keybinds
    hl.exec_cmd(scriptsDir .. "/KeybindsLayoutInit.sh")
end)
