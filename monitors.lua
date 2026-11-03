-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Monitor configuration.
-- Lua port of monitors.conf
--
-- NOTE: This will be overwritten by nwg-displays once you use it and click
-- apply. A copy of the default lives at
-- ~/.config/hypr/Monitor_Profiles/default.conf
--
-- Run `hyprctl monitors` to get your output names and supported modes.
-- See https://wiki.hypr.land/configuring/core/monitors/

-- Default: preferred mode, automatic position, scale 1
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- High refresh rate: pick the highest refresh rate available
hl.monitor({ output = "", mode = "highrr", position = "auto", scale = 1 })

-- High resolution: pick the highest resolution available
hl.monitor({ output = "", mode = "highres", position = "auto", scale = 1 })

-- NOTE: for laptops, check the notes in configs/Laptops.lua regarding displays.
-- These examples are kept so the panel does not wake up unnecessarily.
-- See https://github.com/hyprwm/Hyprland/issues/4090

-- Some examples to set your own monitor
-- hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })
-- hl.monitor({ output = "eDP-1", mode = "2560x1440@165", position = "0x0", scale = 1 }) -- own screen
-- hl.monitor({ output = "DP-3",  mode = "1920x1080@240", position = "auto", scale = 1 })
-- hl.monitor({ output = "DP-1",  mode = "preferred", position = "auto", scale = 1 })
-- hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 1 })

-- QEMU-KVM, VirtualBox or VMware
-- hl.monitor({ output = "Virtual-1", mode = "1920x1080@60", position = "auto", scale = 1 })

-- To disable a monitor
-- hl.monitor({ output = "eDP-1", disabled = true })

-- Mirror samples
-- hl.monitor({ output = "DP-3", mode = "1920x1080@60", position = "0x0", scale = 1, mirror = "DP-2" })
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1, mirror = "eDP-1" })
-- hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@144", position = "0x0", scale = 1, mirror = "eDP-1" })

-- 10 bit monitor support
-- See https://wiki.hypr.land/configuring/core/monitors/
-- NOTE: Colors registered in Hyprland (e.g. the border color) do not support 10 bit.
-- NOTE: Some applications do not support screen capture with 10 bit enabled.
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1, bitdepth = 10 })

-- hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1, transform = 0 })
-- hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1, reserved = { top = 10, right = 10, bottom = 10, left = 49 } })

-- Workspace to monitor rules live in workspaces.lua
-- See https://wiki.hypr.land/configuring/core/rules/workspace-rules/
