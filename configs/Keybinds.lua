-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Default keybinds.
-- Lua port of configs/Keybinds.conf
-- See https://wiki.hypr.land/configuring/core/binds/

-- /* ---- ✴️ Variables ✴️ ---- */  #
local mainMod    = "SUPER"
local home       = os.getenv("HOME")
local scriptsDir = home .. "/.config/hypr/scripts"
local UserConfigs  = home .. "/.config/hypr/UserConfigs"
local UserScripts  = home .. "/.config/hypr/UserScripts"

-- Default apps (terminal / file manager / editor) live in 01-UserDefaults.lua
local defaults = require("UserConfigs.01-UserDefaults")

local term  = defaults.term
local files = defaults.files

-----------------------------------------------------------
---- SMALL HELPERS USED BY SEVERAL BINDS ------------------
-----------------------------------------------------------

-- Multiplies the current desktop zoom factor, clamped to >= 1
local function zoom_by(factor)
    local current = hl.get_config("cursor.zoom_factor") or 1.0
    if current < 1 then
        current = 1
    end
    hl.config({ cursor = { zoom_factor = current * factor } })
end

-- Floats every window on the active workspace
local function float_all()
    local ws = hl.get_active_workspace()
    if not ws then
        return
    end
    for _, w in ipairs(hl.get_workspace_windows(ws)) do
        hl.dispatch(hl.dsp.window.float({ window = w, action = "set" }))
    end
end

-- Finds the monitor sitting in the given direction of the active one
local function monitor_in_direction(dir)
    local cur = hl.get_active_monitor()
    if not cur then
        return nil
    end

    local best, bestDist = nil, math.huge
    for _, m in ipairs(hl.get_monitors()) do
        if m.id ~= cur.id then
            local dist
            if dir == "l" and m.x + m.width <= cur.x then
                dist = cur.x - (m.x + m.width)
            elseif dir == "r" and m.x >= cur.x + cur.width then
                dist = m.x - (cur.x + cur.width)
            elseif dir == "u" and m.y + m.height <= cur.y then
                dist = cur.y - (m.y + m.height)
            elseif dir == "d" and m.y >= cur.y + cur.height then
                dist = m.y - (cur.y + cur.height)
            end

            if dist and dist < bestDist then
                best, bestDist = m, dist
            end
        end
    end

    return best
end

-- Moves the active workspace to the monitor in the given direction
local function workspace_to_monitor(dir)
    local target = monitor_in_direction(dir)
    if target then
        hl.dispatch(hl.dsp.workspace.move({ monitor = target }))
    end
end

----------------------------
---- STARTUP HOOK ----------
----------------------------

-- Layout aware keybinds
hl.on("hyprland.start", function()
    hl.exec_cmd(scriptsDir .. "/ChangeLayout.sh init")
end)

--------------
---- STANDARD --
--------------

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("pkill rofi || true; rofi -show drun -modi drun,filebrowser,run,window"),
    { description = "app launcher" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd('xdg-open "https://"'), { description = "open default browser" })
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(scriptsDir .. "/OverviewToggle.sh"), { description = "desktop overview" })
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term), { description = "Open terminal" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(files), { description = "file manager" })

-----------------------
---- FEATURES / EXTRAS --
-----------------------

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(scriptsDir .. "/ThemeChanger.sh"), { description = "Global theme switcher using Wallust" })
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd(scriptsDir .. "/KeyHints.sh"), { description = "help / cheat sheet" })
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd(scriptsDir .. "/Refresh.sh"), { description = "refresh bar and menus" })
hl.bind(mainMod .. " + ALT + E", hl.dsp.exec_cmd(scriptsDir .. "/RofiEmoji.sh"), { description = "emoji menu" })
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(scriptsDir .. "/RofiSearch.sh"), { description = "web search" })
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("rofi -show window"), { description = "window switcher" })
hl.bind(mainMod .. " + ALT + O", hl.dsp.exec_cmd(scriptsDir .. "/ChangeBlur.sh"), { description = "toggle blur" })
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd(scriptsDir .. "/GameMode.sh"), { description = "toggle game mode" })
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(scriptsDir .. "/ChangeLayout.sh"), { description = "toggle master/dwindle layout" })
hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd(scriptsDir .. "/ClipManager.sh"), { description = "clipboard manager" })
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd(scriptsDir .. "/RofiThemeSelector.sh"), { description = "rofi theme selector" })
hl.bind(mainMod .. " + CTRL + SHIFT + R", hl.dsp.exec_cmd("pkill rofi || true && " .. scriptsDir .. "/RofiThemeSelector-modified.sh"),
    { description = "rofi theme selector (modified)" })

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen(), { description = "fullscreen" })
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ mode = "maximized" }), { description = "maximize window" })
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }), { description = "Float current window" })
hl.bind(mainMod .. " + ALT + SPACE", float_all, { description = "Float all windows" })
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(scriptsDir .. "/Dropterminal.sh " .. term), { description = "DropDown terminal" })

-- Desktop zooming or magnifier
hl.bind(mainMod .. " + ALT + mouse_down", function() zoom_by(2.0) end, { description = "zoom in" })
hl.bind(mainMod .. " + ALT + mouse_up", function() zoom_by(1 / 2.0) end, { description = "zoom out" })

-- Waybar / bar related
hl.bind(mainMod .. " + CTRL + ALT + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"), { description = "toggle waybar on/off" })
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd(scriptsDir .. "/WaybarStyles.sh"), { description = "waybar styles menu" })
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd(scriptsDir .. "/WaybarLayout.sh"), { description = "waybar layout menu" })

-- Night light toggle (Hyprsunset)
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(scriptsDir .. "/Hyprsunset.sh toggle"), { description = "toggle night light" })

-- Features / extras (UserScripts)
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(UserScripts .. "/RofiBeats.sh"), { description = "online music" })
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(UserScripts .. "/WallpaperSelect.sh"), { description = "select wallpaper" })
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(UserScripts .. "/WallpaperEffects.sh"), { description = "wallpaper effects" })
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd(UserScripts .. "/WallpaperRandom.sh"), { description = "random wallpaper" })
hl.bind(mainMod .. " + CTRL + O", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }),
    { description = "toggle active window opacity" })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd(scriptsDir .. "/KeyBinds.sh"), { description = "search keybinds" })
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(scriptsDir .. "/Animations.sh"), { description = "animations menu" })
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(UserScripts .. "/ZshChangeTheme.sh"), { description = "change oh-my-zsh theme" })
hl.bind("ALT_L + SHIFT_L", hl.dsp.exec_cmd(scriptsDir .. "/KeyboardLayout.sh switch"),
    { description = "switch keyboard layout globally", locked = true, non_consuming = true })
hl.bind("SHIFT_L + ALT_L", hl.dsp.exec_cmd(scriptsDir .. "/Tak0-Per-Window-Switch.sh"),
    { description = "switch keyboard layout per-window", locked = true, non_consuming = true })
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd(UserScripts .. "/RofiCalc.sh"), { description = "calculator" })

-- Move current workspace to monitors (left right up or down)
hl.bind(mainMod .. " + CTRL + F9",  function() workspace_to_monitor("l") end, { description = "move workspace to left monitor" })
hl.bind(mainMod .. " + CTRL + F10", function() workspace_to_monitor("r") end, { description = "move workspace to right monitor" })
hl.bind(mainMod .. " + CTRL + F11", function() workspace_to_monitor("u") end, { description = "move workspace to up monitor" })
hl.bind(mainMod .. " + CTRL + F12", function() workspace_to_monitor("d") end, { description = "move workspace to down monitor" })

------------
---- SYSTEM --
------------

hl.bind("CTRL + ALT + Delete", hl.dsp.exit(), { description = "exit Hyprland" })
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "close active window" })
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(scriptsDir .. "/KillActiveProcess.sh"), { description = "Terminate active process" })
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd(scriptsDir .. "/LockScreen.sh"), { description = "lock screen" })
hl.bind("CTRL + ALT + P", hl.dsp.exec_cmd(scriptsDir .. "/Wlogout.sh"), { description = "powermenu" })
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"), { description = "notification panel" })
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(scriptsDir .. "/Kool_Quick_Settings.sh"), { description = "Quick settings menu" })

-------------------
---- MASTER LAYOUT --
-------------------

hl.bind(mainMod .. " + CTRL + D", hl.dsp.layout("removemaster"), { description = "remove master" })
hl.bind(mainMod .. " + I", hl.dsp.layout("addmaster"), { description = "add master" })
-- NOTE: J/K bindings are set dynamically by scripts/KeybindsLayoutInit.sh and
-- scripts/ChangeLayout.sh, so they are intentionally not bound statically here.
hl.bind(mainMod .. " + CTRL + Return", hl.dsp.layout("swapwithmaster"), { description = "swap with master" })

-------------------
---- DWINDLE LAYOUT --
-------------------

hl.bind(mainMod .. " + SHIFT + I", hl.dsp.layout("togglesplit"), { description = "toggle split (dwindle)" })
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), { description = "toggle pseudo (dwindle)" })

-- Works on either layout (Master or Dwindle)
hl.bind(mainMod .. " + M", hl.dsp.layout("splitratio 0.3"), { description = "set split ratio 0.3" })

-----------------------
---- WINDOW CYCLING ----
-----------------------

hl.bind("ALT + tab", hl.dsp.window.cycle_next(), { description = "cycle next window" })
hl.bind("ALT + tab", hl.dsp.window.alter_zorder({ mode = "top" }), { description = "bring active to top" })

---------------------
---- SPECIAL KEYS ----
---------------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --inc"),
    { description = "volume up", repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --dec"),
    { description = "volume down", repeating = true, locked = true })
hl.bind("ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --inc-precise"),
    { description = "volume up precise", repeating = true, locked = true })
hl.bind("ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --dec-precise"),
    { description = "volume down precise", repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle-mic"),
    { description = "toggle mic mute", locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle"),
    { description = "toggle mute", locked = true })
hl.bind("XF86Sleep", hl.dsp.exec_cmd("systemctl suspend"), { description = "sleep", locked = true })
hl.bind("XF86RFKill", hl.dsp.exec_cmd(scriptsDir .. "/AirplaneMode.sh"), { description = "airplane mode", locked = true })

-- Media controls
-- NOTE: Keybinds.conf had `bindld = , xf86AudioPlayPause, …`. Neither the flag
-- (`bindld`) nor the keysym (`XF86AudioPlayPause`) exists, so that line never
-- did anything. The Play/Pause keys below cover the intent.
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { description = "pause", locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { description = "play", locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --nxt"), { description = "next track", locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --prv"), { description = "previous track", locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --stop"), { description = "stop", locked = true })

---------------------
---- SCREENSHOTS ----
---------------------

-- NOTE: You may need to press the Fn key as well
hl.bind("Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"), { description = "screenshot area select" })
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --now"), { description = "screenshot now" })
hl.bind(mainMod .. " + CTRL + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in5"), { description = "screenshot in 5s" })
hl.bind(mainMod .. " + CTRL + SHIFT + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in10"), { description = "screenshot in 10s" })
hl.bind("ALT + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --active"), { description = "screenshot active window" })

-- Screenshot with swappy (another screenshot tool)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --swappy"), { description = "screenshot (swappy)" })

-- Screen recording (wf-recorder)
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(scriptsDir .. "/ScreenRecord.sh --start"), { description = "start screen record (area)" })
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd(scriptsDir .. "/ScreenRecord.sh --stop"), { description = "stop screen record" })

-------------------
---- RESIZE WINDOWS --
-------------------

hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { description = "resize left (-50)", repeating = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }),  { description = "resize right (+50)", repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { description = "resize up (-50)", repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0, y = 50, relative = true }),  { description = "resize down (+50)", repeating = true })

-----------------
---- MOVE WINDOWS --
-----------------

hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ direction = "left" }),  { description = "move window left" })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }), { description = "move window right" })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.move({ direction = "up" }),    { description = "move window up" })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.move({ direction = "down" }),  { description = "move window down" })

------------------
---- SWAP WINDOWS --
------------------

hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.swap({ direction = "left" }),  { description = "swap window left" })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }), { description = "swap window right" })
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.swap({ direction = "up" }),    { description = "swap window up" })
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.swap({ direction = "down" }),  { description = "swap window down" })

--------------
---- GROUPS --
--------------

hl.bind(mainMod .. " + G", hl.dsp.group.toggle(), { description = "toggle group" })

-- Navigate within a group
hl.bind(mainMod .. " + Tab", hl.dsp.group.next(), { description = "Change Group Forward" })
hl.bind(mainMod .. " + CTRL + tab", hl.dsp.group.next(), { description = "change active in group" })
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.group.prev(), { description = "Change Group Back" })

-- Move window into/out of group
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ into_group = "left" }), { description = "Move left into group" })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ into_group = "right" }), { description = "Move Right into group" })
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ out_of_group = true }), { description = "Move active out of group" })

---------------------
---- MOVE FOCUS ----
---------------------

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }),  { description = "focus left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "focus right" })
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }),    { description = "focus up" })
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }),  { description = "focus down" })

-------------------------
---- WORKSPACES --------
-------------------------

hl.bind(mainMod .. " + tab", hl.dsp.focus({ workspace = "m+1" }), { description = "next workspace" })
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.focus({ workspace = "m-1" }), { description = "previous workspace" })

-- Special workspace
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special:special" }), { description = "move to special workspace" })
hl.bind(mainMod .. " + U", hl.dsp.workspace.toggle_special("special"), { description = "toggle special workspace" })

-- The following mappings use key codes to better support various keyboard layouts
-- 1 is code:10, 2 is code:11, etc.
for i = 1, 10 do
    local code = 9 + i -- code:10 (key 1) .. code:19 (key 0)

    hl.bind(mainMod .. " + code:" .. code, hl.dsp.focus({ workspace = i }),
        { description = "workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + code:" .. code, hl.dsp.window.move({ workspace = i }),
        { description = "move to workspace " .. i })
    hl.bind(mainMod .. " + CTRL + code:" .. code, hl.dsp.window.move({ workspace = i .. " silent" }),
        { description = "move silently to workspace " .. i })
end

hl.bind(mainMod .. " + SHIFT + bracketleft",  hl.dsp.window.move({ workspace = "-1" }),  { description = "move to previous workspace" })
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = "+1" }),  { description = "move to next workspace" })
hl.bind(mainMod .. " + CTRL + bracketleft",   hl.dsp.window.move({ workspace = "-1 silent" }), { description = "move silently to previous workspace" })
hl.bind(mainMod .. " + CTRL + bracketright",  hl.dsp.window.move({ workspace = "+1 silent" }), { description = "move silently to next workspace" })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "next workspace" })
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "previous workspace" })
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "e+1" }), { description = "next workspace" })
hl.bind(mainMod .. " + comma",  hl.dsp.focus({ workspace = "e-1" }), { description = "previous workspace" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { description = "move window", mouse = true })   -- left click
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { description = "resize window", mouse = true }) -- right click
