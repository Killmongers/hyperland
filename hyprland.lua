-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Hyprland entry point. Hyprland 0.57+ loads this file instead of hyprland.conf.
--
-- Up to 0.56 hyprland.conf "sourced" a tree of hyprlang .conf files. 0.57
-- resolves the config through Lua's require(), which cannot read hyprlang
-- .conf files, so every file of that tree now has a .lua sibling holding the
-- same logic. The require() order below mirrors the old source= order in
-- hyprland.conf, because later modules override earlier ones.
--
-- The original .conf files are left in place for rollback; Hyprland ignores
-- them now. If you edit a setting, edit the .lua file.
--
-- See https://wiki.hypr.land/configuring/core/

-------------------------------------------------------------
---- INITIAL BOOT ----
-------------------------------------------------------------

-- Applies the initial wallpaper, theming and settings once per fresh install.
-- Keep ~/.config/hypr/.initial_startup_done in place, otherwise this re-runs.
hl.on("hyprland.start", function()
    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/initial-boot.sh")
end)

-------------------------------------------------------------
---- CONFIG MODULES (same order as hyprland.conf) ----
-------------------------------------------------------------

-- Pre-configured keybinds (also requires UserConfigs/01-UserDefaults.lua for
-- the terminal / file manager names)
require("configs.Keybinds")

-- Autostart: defaults first, then user additions
require("configs.Startup_Apps")
require("UserConfigs.Startup_Apps")

-- Environment variables: defaults, then user
require("configs.ENVariables")
require("UserConfigs.ENVariables")

-- Laptop related (battery, backlight, lid switch)
require("configs.Laptops")
require("UserConfigs.Laptops")
require("UserConfigs.LaptopDisplay")

-- Window and layer rules: defaults, then user additions
require("configs.WindowRules")
require("UserConfigs.WindowRules")

-- Default Hyprland settings (layouts, input, gestures, misc)
require("configs.SystemSettings")

-- Look and feel, animations and user overrides
require("UserConfigs.UserDecorations")
require("UserConfigs.UserAnimations")
require("UserConfigs.UserKeybinds")
require("UserConfigs.UserSettings")
require("UserConfigs.01-UserDefaults")

-- Monitors and workspace rules.
-- NOTE: nwg-displays still writes monitors.conf / workspaces.conf, which this
-- file cannot load any more. Port its output here (or into these two modules)
-- after applying a layout.
require("monitors")
require("workspaces")
