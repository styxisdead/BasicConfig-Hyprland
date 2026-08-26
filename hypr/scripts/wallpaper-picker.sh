#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

WALLPAPER=$(
    find "$WALLPAPER_DIR" -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) |
    while IFS= read -r file; do
        printf '%s\0icon\x1f%s\n' "$file" "$file"
    done |
    rofi \
        -dmenu \
        -i \
        -p "Wallpaper" \
        -show-icons \
        -theme "$HOME/.config/rofi/wallpaper.rasi"
)

if [ -z "$WALLPAPER" ]; then
    exit 0
fi

"$HOME/.config/hypr/scripts/wallpaper.sh" "$WALLPAPER"
