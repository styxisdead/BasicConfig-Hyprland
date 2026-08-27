#!/bin/bash
set -euo pipefail

# ============================================================
# BasicConfig-Hyprland Installer
# ============================================================

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/hypr_backup_$(date +%Y%m%d_%H%M%S)"

# PACKAGES=(
#    hyprland
#    waybar
#    rofi
#    kitty
#    hyprpaper
#    mako
#    nemo
#    matugen
#    hyprpolkitagent

#    pipewire
#    pipewire-pulse
#    wireplumber

#    grim
#    slurp
#    wl-clipboard

#    ttf-font-awesome
#    ttf-jet-brains-mono

#    qt5-wayland
#    qt6-wayland
#    xdg-desktop-portal-hyprland

#    btop
#    cava
#    spotify-player
#    fastfetch
#    fuzzel

#    gtk3
#    gtk4
#    firefox
#    qt6ct

#    fish
# )

echo "==========================================="
echo "=== INSTALLING BASIC HYPRLAND CONFIG... ==="
echo "==========================================="
echo

# ------------------------------------------------------------
# Check that the script is inside the dotfiles directory
# ------------------------------------------------------------

if [ ! -d "$SCRIPT_DIR/hypr" ]; then
    echo "ERROR: Hyprland configuration was not found."
    echo
    echo "Expected the dotfiles to be located beside install.sh."
    exit 1
fi

# ------------------------------------------------------------
# Install packages
# ------------------------------------------------------------

# echo "Installing system dependencies..."

# sudo pacman -Syu --needed "${PACKAGES[@]}"

# ------------------------------------------------------------
# Create ~/.config
# ------------------------------------------------------------

mkdir -p "$CONFIG_DIR"

# ------------------------------------------------------------
# Configuration directories to back up
# ------------------------------------------------------------

FOLDERS=(
    hypr
    waybar
    rofi
    kitty
    hyprpaper
    mako
    nemo
    matugen
    btop
    cava
    spotify-player
    fastfetch
    fuzzel
    gtk-3.0
    gtk-4.0
    firefox
    qt6ct
)

# ------------------------------------------------------------
# Back up existing configurations
# ------------------------------------------------------------

echo
echo "Checking for existing configurations..."

BACKUP_CREATED=false

for folder in "${FOLDERS[@]}"; do
    if [ -d "$CONFIG_DIR/$folder" ]; then

        if [ "$BACKUP_CREATED" = false ]; then
            mkdir -p "$BACKUP_DIR"
            BACKUP_CREATED=true
        fi

        echo "Backing up ~/.config/$folder"
        mv "$CONFIG_DIR/$folder" "$BACKUP_DIR/"
    fi
done

if [ "$BACKUP_CREATED" = true ]; then
    echo
    echo "Existing configurations backed up to:"
    echo "$BACKUP_DIR"
else
    echo "No existing configurations found."
fi

# ------------------------------------------------------------
# Deploy dotfiles
# ------------------------------------------------------------

echo
echo "Deploying BasicConfig-Hyprland configuration..."

cp -r "$SCRIPT_DIR/." "$CONFIG_DIR/"

# ------------------------------------------------------------
# Make Hyprland scripts executable
# ------------------------------------------------------------

if [ -d "$CONFIG_DIR/hypr/scripts" ]; then
    echo "Making Hyprland scripts executable..."

    find "$CONFIG_DIR/hypr/scripts" \
        -type f \
        -exec chmod +x {} \;
fi

# ------------------------------------------------------------
# Fish shell
# ------------------------------------------------------------

 echo
 read -r -p "Do you want to set Fish as your default shell? [y/N]: " REPLY

echo

 if [[ "$REPLY" =~ ^[Yy]$ ]]; then

   FISH_PATH="$(command -v fish)"

    if [ -z "$FISH_PATH" ]; then
        echo "ERROR: Fish was not found."
        exit 1
    fi

    if ! grep -Fxq "$FISH_PATH" /etc/shells; then
        echo "Adding Fish to /etc/shells..."
        echo "$FISH_PATH" | sudo tee -a /etc/shells > /dev/null
    fi

    echo "Setting Fish as your default shell..."
    chsh -s "$FISH_PATH"
fi

# ------------------------------------------------------------
# Enable system services
# ------------------------------------------------------------

echo
echo "Enabling system services..."

sudo systemctl enable --now NetworkManager.service

if systemctl list-unit-files bluetooth.service >/dev/null 2>&1; then
    sudo systemctl enable --now bluetooth.service
fi

# ------------------------------------------------------------
# Initialize Matugen
# ------------------------------------------------------------

WALLPAPER="$CONFIG_DIR/hypr/Wallpapers/Moon.png"

if [ -f "$WALLPAPER" ]; then
    echo
    echo "Initializing Matugen..."
    matugen image "$WALLPAPER"
fi

# ------------------------------------------------------------
# Finish
# ------------------------------------------------------------

echo
echo "==============================================="
echo "=== INSTALLATION COMPLETE. REBOOTING NOW... ==="
echo "==============================================="
echo

sleep 3

sudo systemctl reboot
