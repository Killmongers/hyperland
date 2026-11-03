#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for changing blurs on the fly
#
# Hyprland 0.57 removed `hyprctl keyword`; values are set with `hl.config()`
# inside a Lua chunk passed to `hyprctl dispatch`.

notif="$HOME/.config/swaync/images"

STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

if [ "${STATE}" == "2" ]; then
        hyprctl dispatch 'function() hl.config({ decoration = { blur = { size = 2, passes = 1 } } }) end'
        notify-send -e -u low -i "$notif/note.png" " Less Blur"
else
        hyprctl dispatch 'function() hl.config({ decoration = { blur = { size = 5, passes = 2 } } }) end'
        notify-send -e -u low -i "$notif/ja.png" " Normal Blur"
fi
