#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Initialize J/K keybinds so they always cycle windows globally (no layout-specific behavior)
# This avoids double-actions when layouts change.
#
# Hyprland 0.57 removed `hyprctl keyword`; binds are now applied through a Lua
# chunk evaluated by `hyprctl dispatch`.

set -uo pipefail

# Always reset and bind SUPER+J/K the same way on startup
hyprctl dispatch 'function()
  hl.unbind("SUPER + J")
  hl.unbind("SUPER + K")

  -- Cycle windows globally: J = next, K = previous
  hl.bind("SUPER + J", hl.dsp.window.cycle_next(), { description = "cycle next" })
  hl.bind("SUPER + K", hl.dsp.window.cycle_next({ next = false }), { description = "cycle previous" })
end'
