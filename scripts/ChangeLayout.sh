#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# for changing Hyprland Layouts (Master or Dwindle) on the fly
#
# Hyprland 0.57 removed `hyprctl keyword`. Runtime changes now go through
# `hyprctl dispatch` with a Lua expression, so everything below is a small Lua
# chunk evaluated by the compositor.

notif="$HOME/.config/swaync/images/ja.png"

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

# Reverse layout value to reuse toggle logic. So layouts don't get swapped initially.
if [ "$1" = "init" ]; then
  if [ "$LAYOUT" = "master" ]; then
    LAYOUT="dwindle"
  else
    LAYOUT="master"
  fi
fi

case $LAYOUT in
"master")
  hyprctl dispatch 'function()
    hl.config({ general = { layout = "dwindle" } })
    hl.unbind("SUPER + J")
    hl.unbind("SUPER + K")
    hl.bind("SUPER + J", hl.dsp.window.cycle_next(), { description = "cycle next" })
    hl.bind("SUPER + K", hl.dsp.window.cycle_next({ next = false }), { description = "cycle previous" })
    hl.bind("SUPER + O", hl.dsp.layout("togglesplit"), { description = "toggle split" })
  end'
  notify-send -e -u low -i "$notif" " Dwindle Layout"
  ;;
"dwindle")
  hyprctl dispatch 'function()
    hl.config({ general = { layout = "master" } })
    hl.unbind("SUPER + J")
    hl.unbind("SUPER + K")
    hl.unbind("SUPER + O")
    hl.bind("SUPER + J", hl.dsp.layout("cyclenext"), { description = "cycle next (master)" })
    hl.bind("SUPER + K", hl.dsp.layout("cycleprev"), { description = "cycle previous (master)" })
  end'
  notify-send -e -u low -i "$notif" " Master Layout"
  ;;
*) ;;

esac
