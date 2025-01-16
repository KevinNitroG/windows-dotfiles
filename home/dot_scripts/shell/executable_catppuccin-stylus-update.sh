#!/bin/bash

URL="https://github.com/catppuccin/userstyles/releases/download/all-userstyles-export/import.json"
FILE_DIR="$HOME/.config/browser-data/stylus"
FILE_PATH="$FILE_DIR/catppuccin.json"

mkdir -p "$FILE_DIR"

if command -v curl &>/dev/null; then
  curl -L -o "$FILE_PATH" "$URL"
elif command -v wget &>/dev/null; then
  wget -qO "$FILE_PATH" "$URL"
else
  echo "No curl or wget available!"
  exit 1
fi

sed -i 's/"name":"accentColor","value":null/"name":"accentColor","value":"lavender"/g' "$FILE_PATH"
