-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Animation theme: HYDE - Vertical
-- Lua port of animations/HYDE - Vertical.conf
-- Applied by scripts/Animations.sh (SUPER + SHIFT + A).
-- See https://wiki.hypr.land/configuring/core/animations/


hl.config({
    animations = {
        enabled = true,
    },
})

-- Curves
hl.curve("fluent_decel", { type = "bezier", points = { {0, 0.2}, {0.4, 1} } })
hl.curve("easeOutCirc", { type = "bezier", points = { {0, 0.55}, {0.45, 1} } })
hl.curve("easeOutCubic", { type = "bezier", points = { {0.33, 1}, {0.68, 1} } })
hl.curve("easeinoutsine", { type = "bezier", points = { {0.37, 0}, {0.63, 1} } })

-- Animations
hl.animation({ leaf = "windowsIn", enabled = true, speed = 1.5, bezier = "easeinoutsine", style = "popin 60%" }) -- window open
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.5, bezier = "easeOutCubic", style = "popin 60%" }) -- window close.
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1.5, bezier = "easeinoutsine", style = "slide" }) -- everything in between, moving, dragging, resizing.
hl.animation({ leaf = "fade", enabled = true, speed = 2.5, bezier = "fluent_decel" })
hl.animation({ leaf = "fadeLayersIn", enabled = false })
hl.animation({ leaf = "border", enabled = false })
hl.animation({ leaf = "layers", enabled = true, speed = 1.5, bezier = "easeinoutsine", style = "popin" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "fluent_decel", style = "slidefadevert 30%" }) -- styles: slide, slidevert, fade, slidefade, slidefadevert
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "fluent_decel", style = "slidefade 10%" })
