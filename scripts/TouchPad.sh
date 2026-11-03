#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# For disabling touchpad.
# Edit touchpad_device in ~/.config/hypr/UserConfigs/Laptops.lua (or the default
# in ~/.config/hypr/configs/Laptops.lua) according to your system.
# use hyprctl devices to get your system touchpad device name
# source https://github.com/hyprwm/Hyprland/discussions/4283?sort=new#discussioncomment-8648109
#
# Hyprland 0.57 removed `hyprctl keyword`, so the device state is toggled with a
# `hl.device()` call passed to `hyprctl dispatch`.

set -euo pipefail

notif="$HOME/.config/swaync/images/ja.png"
laptops_lua="$HOME/.config/hypr/UserConfigs/Laptops.lua"
defaults_lua="$HOME/.config/hypr/configs/Laptops.lua"

# Read `local touchpad_device = "..."` out of a Lua module.
read_device() {
    [[ -f "$1" ]] || return 0
    awk -F= '/^[[:space:]]*local[[:space:]]+touchpad_device[[:space:]]*=/ {
        v = $2;
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", v);
        gsub(/"/, "", v);
        print v;
        exit
    }' "$1"
}

touchpad_device="${TOUCHPAD_DEVICE:-}"
if [[ -z "$touchpad_device" ]]; then
    touchpad_device="$(read_device "$laptops_lua")"
fi
if [[ -z "$touchpad_device" ]]; then
    touchpad_device="$(read_device "$defaults_lua")"
fi

if [[ -z "$touchpad_device" ]]; then
    notify-send -u low -i "$notif" " Touchpad" " Device name not set (check UserConfigs/Laptops.lua)"
    exit 1
fi

status_file="${XDG_RUNTIME_DIR:-/tmp}/touchpad.status"

set_touchpad() {
    hyprctl dispatch "function() hl.device({ name = \"$touchpad_device\", enabled = $1 }) end" >/dev/null
}

enable_touchpad() {
    printf "true" >"$status_file"
    notify-send -u low -i "$notif" " Enabling" " touchpad"
    set_touchpad true
}

disable_touchpad() {
    printf "false" >"$status_file"
    notify-send -u low -i "$notif" " Disabling" " touchpad"
    set_touchpad false
}

current_state="false"
if [[ -f "$status_file" ]]; then
    current_state="$(<"$status_file")"
fi

if [[ "$current_state" == "true" ]]; then
    disable_touchpad
else
    enable_touchpad
fi
