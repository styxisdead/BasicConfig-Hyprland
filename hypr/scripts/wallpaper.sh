#!/bin/bash

WALLPAPER="$1"
CONFIG="$HOME/.config/hypr/hyprpaper.conf"

if [ -z "$WALLPAPER" ]; then
    echo "Usage: wallpaper.sh /path/to/wallpaper"
    exit 1
fi

if [ ! -f "$WALLPAPER" ]; then
    echo "Wallpaper does not exist: $WALLPAPER"
    exit 1
fi

# Update hyprpaper configuration
cat > "$CONFIG" <<EOF
splash = false

wallpaper {
    monitor = DP-2
    path = $WALLPAPER
    fit_mode = cover
}

wallpaper {
    monitor = HDMI-A-1
    path = $WALLPAPER
    fit_mode = cover
}
EOF

# Restart hyprpaper with the new wallpaper
pkill hyprpaper
hyprpaper &

# Generate colors from the new wallpaper
matugen image --source-color-index 0 "$WALLPAPER"
