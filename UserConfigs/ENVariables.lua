-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Environment variables (user overrides).
-- Lua port of UserConfigs/ENVariables.conf
-- Runs after configs/ENVariables.lua, so these win.

-- NVIDIA
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")

-- nvidia firefox
-- See https://github.com/elFarto/nvidia-vaapi-driver#configuration
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("EGL_PLATFORM", "wayland")
