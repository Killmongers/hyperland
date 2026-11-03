#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Game Mode. Turning off all animations
#
# Hyprland 0.57 removed `hyprctl keyword` (and its --batch equivalent), so the
# values are applied in one Go by a Lua chunk handed to `hyprctl dispatch`.
# Turning game mode off simply reloads the config, which re-applies every module.

notif="$HOME/.config/swaync/images/ja.png"
SCRIPTSDIR="$HOME/.config/hypr/scripts"

# NOTE: getoption reports booleans as `bool: true` since 0.57
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = "true" ] ; then
    hyprctl dispatch 'function()
      hl.config({
        animations = { enabled = false },
        decoration = {
          rounding        = 0,
          shadow          = { enabled = false },
          blur            = { enabled = false },
          active_opacity  = 1,
          inactive_opacity = 1,
        },
        general = { gaps_in = 0, gaps_out = 0, border_size = 1 },
      })
    end'
    awww kill
    notify-send -e -u low -i "$notif" " Gamemode:" " enabled"
    sleep 0.1
    exit
else
    awww-daemon --format xrgb && awww img "$HOME/.config/rofi/.current_wallpaper" &
    sleep 0.1
    ${SCRIPTSDIR}/WallustSwww.sh
    sleep 0.5
    hyprctl reload
    ${SCRIPTSDIR}/Refresh.sh
    notify-send -e -u normal -i "$notif" " Gamemode:" " disabled"
    exit
fi
hyprctl reload
