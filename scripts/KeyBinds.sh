#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# searchable enabled keybinds using rofi
#
# Hyprland 0.57 has no hyprlang bind lines left to parse, so the list is taken
# straight from the running compositor (`hyprctl binds -j`). That also picks up
# binds created at runtime by ChangeLayout.sh / KeybindsLayoutInit.sh.

# kill yad to not interfere with this binds
pkill yad || true

# check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

rofi_theme="$HOME/.config/rofi/config-keybinds.rasi"
msg='☣️ NOTE ☣️: Clicking with Mouse or Pressing ENTER will have NO function'

# Build the list from the live bindings. modmask is a bitfield, so each
# modifier is a single bit test.
display_keybinds=$(hyprctl binds -j | jq -r '
  def mods:
    [ (if ((.modmask / 64 | floor) % 2) == 1 then "SUPER" else empty end),
      (if ((.modmask / 4  | floor) % 2) == 1 then "CTRL"  else empty end),
      (if ((.modmask / 8  | floor) % 2) == 1 then "ALT"   else empty end),
      (if ((.modmask / 1  | floor) % 2) == 1 then "SHIFT" else empty end) ];
  def desc_of:
    if (.description // "") != "" then .description
    else (.dispatcher | sub("^HL\\.Dispatcher\\("; "") | sub("\\)$"; ""))
    end;
  .[]
  | (mods + [.key] | join(" + ")) + "  —  " + desc_of
' | sort -f)

# use rofi to display the keybinds
printf '%s\n' "$display_keybinds" | rofi -dmenu -i -config "$rofi_theme" -mesg "$msg"
