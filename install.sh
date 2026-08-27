#!/bin/bash
set -e

PACKAGES=(
    hyprland waybar rofi kitty hyprpaper mako nemo matugen hyprpolkitagent 
    pulseaudio grim slurp wl-clipboard grimblast systray ttf-font-awesome 
    ttf-jet-brains-mono qt5-wayland qt6-wayland xdg-desktop-portal-hyprland
    btop cava spotify_player fastfetch fuzzel gtk-3.0 gtk-4.0 firefox qt6ct 
)

echo "==========================================="
echo "=== INSTALLING BASIC HYPRLAND CONFIG... ==="
echo "==========================================="

echo "WARNING: PLEASE NOTE THIS IS NOT A FULLY FLESHED INSTALL SCRIPT. SOME PACKAGES MAY BE MISSING. THIS IS JUST A SIMPLE CONFIGURATION."

echo "Installing system dependencies..."
sudo pacman -Syu --needed "${PACKAGES[@]}"

mkdir -p "$HOME/.config"
BACKUP_DIR="$HOME/.config/hypr_backup_$(date +%Y%m%d_%H%M%S)"

FOLDERS=(
    hyprland 
    waybar 
    rofi 
    kitty 
    hyprpaper 
    mako 
    nemo 
    matugen 
    hyprpolkitagent 
    pulseaudio 
    grim 
    slurp 
    wl-clipboard 
    grimblast 
    systray 
    ttf-font-awesome 
    ttf-jet-brains-mono 
    qt5-wayland 
    qt6-wayland 
    xdg-desktop-portal-hyprland
    btop 
    cava 
    spotify_player 
    fastfetch 
    fuzzel 
    gtk-3.0 
    gtk-4.0 
    firefox 
    qt6ct 
)

echo "Backing up existing configurations to $BACKUP_DIR..."
for folder in "${FOLDERS[@]}"; do
    if [ -d "$HOME/.config/$folder" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$HOME/.config/$folder" "$BACKUP_DIR/"
    fi
done

echo "Deploying new dotfiles, hang tight...!"
cp -r dotfiles/* "$HOME/.config"

if [ -d "$HOME/.config/hypr/scripts" ]; then
    chmod +x "$HOME/.config/hypr/scripts"/*
fi

echo ""
read -p "Do you want to set fish as your defauly system shell? (This is reccommended for beginner users) [y/N]: " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    FISH_PATH=$(which fish)
    if ! grep -q "$FISH_PATH" /etc/shells; then
        echo "Adding fish to /etc/shells..."
        echo "$FISH_PATH" | sudo tee -a /etc/shells
    fi
    echo "Setting fish as your default shell..."
    chsh -s "$FISH_PATH"
fi

if pidof systemd >/dev/null; then
    echo "Systemd active, enabling background services now..."
    sudo systemctl enable --now NetworkManager.service
    sudo systemctl enable --now bluetooth.service
    sudo systemctl enable --now pipewire.service pipewire-pulse.service wireplumber.service
fi

if [ -f "$HOME/.config/hypr/Wallpapers/Moon.png" ]; then
    echo "Initializing themes..."
    matugen image "$HOME/.config/hypr/Wallpapers/Moon.png"
fi

echo "==============================================="
echo "=== INSTALLATION COMPLETE. REBOOTING NOW... ==="
echo "==============================================="

sudo systemctl reboot
