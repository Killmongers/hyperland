-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Animation theme: ML4W - classic
-- Lua port of animations/ML4W - classic.conf
-- Applied by scripts/Animations.sh (SUPER + SHIFT + A).
-- See https://wiki.hypr.land/configuring/core/animations/


hl.config({
    animations = {
        enabled = true,
    },
})

-- Curves
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

-- Animations
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })
