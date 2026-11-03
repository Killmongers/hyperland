#!/usr/bin/env bash
# Script to update WindowRules config if Hyprland version is >= 0.53
#
# Hyprland 0.57 loads Lua configs, and configs/WindowRules.lua is already
# written in the 0.53+ rule syntax, so there is nothing left to migrate.
# The old hyprlang files (configs/WindowRules.conf, WindowRules-config-v3.conf,
# WindowRules-pre-53.conf) are only kept around for rollback.
#
# Kept so existing keybinds / menus that call this script do not break.

CONFIGS_DIR="$HOME/.config/hypr/configs"
TARGET_FILE="$CONFIGS_DIR/WindowRules.lua"

if [[ -f "$TARGET_FILE" ]]; then
  echo "Window rules are already in Lua: $TARGET_FILE"
  echo "Nothing to migrate. Edit that file to change rules."
else
  echo "Error: $TARGET_FILE not found." >&2
  exit 1
fi
