-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Laptop related keybinds and devices (defaults).
-- Lua port of configs/Laptops.conf
--
-- Notes regarding displays are in monitors.lua.
-- See https://wiki.hypr.land/configuring/core/devices/

local mainMod    = "SUPER"
local scriptsDir = os.getenv("HOME") .. "/.config/hypr/scripts"

-- Touchpad device. Run `hyprctl devices` to get your own device name.
-- scripts/TouchPad.sh reads the touchpad_device below.
local touchpad_device  = "asue1209:00-04f3:319f-touchpad"
local touchpad_enabled = true

-- Keyboard and monitor brightness
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd(scriptsDir .. "/BrightnessKbd.sh --dec"), { repeating = true })
hl.bind("XF86KbdBrightnessUp",   hl.dsp.exec_cmd(scriptsDir .. "/BrightnessKbd.sh --inc"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(scriptsDir .. "/Brightness.sh --dec"),    { repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(scriptsDir .. "/Brightness.sh --inc"),    { repeating = true })

-- ASUS ROG keys (FN+F4 keyboard RGB profile, FN+F5 fan profile)
hl.bind("XF86Launch1", hl.dsp.exec_cmd("rog-control-center"))   -- Armoury Crate button
hl.bind("XF86Launch3", hl.dsp.exec_cmd("asusctl led-mode -n"))  -- FN+F4 switch keyboard RGB profile
hl.bind("XF86Launch4", hl.dsp.exec_cmd("asusctl profile -n"))   -- FN+F5 change fan profile (Quiet, Balance, Performance)

-- Touchpad toggle
hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd(scriptsDir .. "/TouchPad.sh"))

-- Screenshot keybindings using F6 (no Print key on some laptops)
hl.bind(mainMod .. " + F6",           hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --now"))
hl.bind(mainMod .. " + SHIFT + F6",   hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"))
hl.bind(mainMod .. " + CTRL + F6",    hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in5"))
hl.bind(mainMod .. " + ALT + F6",     hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in10"))
hl.bind("ALT + F6",                   hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --active"))

-- Touchpad device
hl.device({
    name    = touchpad_device,
    enabled = touchpad_enabled,
})
