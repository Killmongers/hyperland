-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Animation theme: HYDE - minimal-2
-- Lua port of animations/HYDE - minimal-2.conf
-- Applied by scripts/Animations.sh (SUPER + SHIFT + A).
-- See https://wiki.hypr.land/configuring/core/animations/


hl.config({
    animations = {
        enabled = true,
    },
})

-- Curves
hl.curve("quart", { type = "bezier", points = { {0.25, 1}, {0.5, 1} } })

-- Animations
hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "quart", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "quart" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 6, bezier = "quart" })
hl.animation({ leaf = "fade", enabled = true, speed = 6, bezier = "quart" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "quart" })
