#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

WALLPAPER=$(find "$WALLPAPER_DIR" -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) |
    shuf -n 1)

if [ -z "$WALLPAPER" ]; then
    echo "No wallpapers found."
    exit 1
fi

"$HOME/.config/hypr/scripts/wallpaper.sh" "$WALLPAPER"
