-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Environment variables (defaults).
-- Lua port of configs/ENVariables.conf
-- See https://wiki.hypr.land/configuring/core/environment-variables/

-- Set your default editor through ENV in UserConfigs/01-UserDefaults.lua

-- Current version of JaKooLit dotfiles
hl.env("DOTS_VERSION", "2.3.20")

-- Toolkit backend variables
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("CLUTTER_BACKEND", "wayland")

-- Run SDL2 applications on Wayland.
-- Remove or set to x11 if games that provide older versions of SDL cause compatibility issues
-- hl.env("SDL_VIDEODRIVER", "wayland")

-- XDG specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Qt variables
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- hyprland-qt-support
hl.env("QT_QUICK_CONTROLS_STYLE", "org.hyprland.style")

-- xwayland apps scale fix (useful if you use monitor scaling)
-- Set same value if you use scaling in monitors.lua
-- 1 is 100% 1.5 is 150%
-- See https://wiki.hypr.land/configuring/extra/xwayland/
hl.env("GDK_SCALE", "1")
hl.env("QT_SCALE_FACTOR", "1")

-- Bibata-Modern-Ice cursor
-- NOTE! You must have the hyprcursor version to activate this.
-- https://wiki.hypr.land/Hypr-Ecosystem/hyprcursor/
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

-- Firefox
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Electron
-- https://www.electronjs.org/docs/latest/api/environment-variables
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto") -- auto selects Wayland if possible, X11 otherwise

-- NVIDIA
-- This is from the Hyprland wiki. Below will be activated if an NVIDIA GPU is detected
-- See https://wiki.hypr.land/Advanced/nvidia/
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("GSK_RENDERER", "ngl")

-- Additional ENVs for nvidia. Caution, activate with care
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GL_GSYNC_ALLOWED", "1")        -- adaptive Vsync
-- hl.env("__NV_PRIME_RENDER_OFFLOAD", "1")
-- hl.env("__VK_LAYER_NV_optimus", "NVIDIA_only")
-- hl.env("WLR_DRM_NO_ATOMIC", "1")

-- For VM and possibly NVIDIA
-- LIBGL_ALWAYS_SOFTWARE software mesa rendering
-- hl.env("LIBGL_ALWAYS_SOFTWARE", "1")     -- Warning. May cause Hyprland to crash
-- hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")

-- nvidia firefox
-- See https://github.com/elFarto/nvidia-vaapi-driver#configuration
-- hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
-- hl.env("EGL_PLATFORM", "wayland")

-- Aquamarine environment variables (Hyprland > 0.45)
-- See https://wiki.hypr.land/Configuring/Environment-variables/
-- hl.env("AQ_TRACE", "1")                  -- Enables more verbose logging.
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card0") -- Explicit DRM device list (GPUs), first is primary
-- hl.env("AQ_MGPU_NO_EXPLICIT", "1")       -- Disables explicit syncing on mgpu buffers
-- hl.env("AQ_NO_MODIFIERS", "1")           -- Disables modifiers for DRM buffers

-- Hyprland environment variables
-- hl.env("HYPRLAND_TRACE", "1")            -- Enables more verbose logging.
-- hl.env("HYPRLAND_NO_RT", "1")            -- Disables realtime priority setting by Hyprland.
-- hl.env("HYPRLAND_NO_SD_NOTIFY", "1")     -- If systemd, disables the 'sd_notify' calls.
-- hl.env("HYPRLAND_NO_SD_VARS", "1")       -- Disables management of variables in systemd and dbus activation environments.
