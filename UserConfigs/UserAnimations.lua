-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Animations.
-- Lua port of UserConfigs/UserAnimations.conf
--
-- scripts/Animations.sh (SUPER + SHIFT + A) replaces this whole file with one
-- of the themes in animations/*.lua.
-- See https://wiki.hypr.land/configuring/core/animations/

hl.config({
    animations = {
        enabled = true,
    },
})

-- Custom curves
hl.curve("wind",      { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05}  } })
hl.curve("winIn",     { type = "bezier", points = { {0.1, 1.1},   {0.1, 1.1}   } })
hl.curve("winOut",    { type = "bezier", points = { {0.3, -0.3},  {0, 1}       } })
hl.curve("liner",     { type = "bezier", points = { {1, 1},       {1, 1}       } })
hl.curve("overshot",  { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05}  } })
hl.curve("smoothOut", { type = "bezier", points = { {0.5, 0},     {0.99, 0.99} } })
hl.curve("smoothIn",  { type = "bezier", points = { {0.5, -0.5},  {0.68, 1.5}  } })

-- Animations
hl.animation({ leaf = "windows",       enabled = true, speed = 6, bezier = "wind",      style = "slide" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 5, bezier = "winIn",     style = "slide" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 3, bezier = "smoothOut", style = "slide" })
hl.animation({ leaf = "windowsMove",   enabled = true, speed = 5, bezier = "wind",      style = "slide" })
hl.animation({ leaf = "border",        enabled = true, speed = 1, bezier = "liner" })
-- NOTE: hyprlang accepted speed 180 here, the Lua API caps speed at 100.
hl.animation({ leaf = "borderangle",   enabled = true, speed = 100, bezier = "liner",   style = "loop" }) -- used by rainbow borders and rotating colors
hl.animation({ leaf = "fade",          enabled = true, speed = 3, bezier = "smoothOut" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 5, bezier = "overshot" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 5, bezier = "winIn",     style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 5, bezier = "winOut",    style = "slide" })
