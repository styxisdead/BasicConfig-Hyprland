# BasicConfig-Hyprland

A simple Hyprland configuration for Arch Linux.

## Requirements

This configuration is intended for **Arch Linux only** or an Arch-based system.

You will need:

- A working Arch Linux installation
- An internet connection
- `sudo`
- `git`
- `fish`
- `kitty`
- `fastfetch`
- `rofi`
- `waybar`
- `fuzzel`
- `mako`
- `matugen`
- `hyprpaper`
- `hyprglass plugin`
- `btop`

## Installation

### 1. Install necessary packages

```bash
sudo pacman -S git
```
```bash
sudo pacman -S kitty fish fastfetch rofi waybar fuzzel mako matugen hyprpaper btop
```


NOTE: the installer has packages commented out for debugging purposes. I will fix the install script when I have time.

### 2. Clone the repository

```bash
git clone https://github.com/styxisdead/BasicConfig-Hyprland.git
```

### 3. Enter the repository

```bash
cd BasicConfig-Hyprland
```

### 4. Make the installer executable

```bash
chmod +x install.sh
```

### 5. Run the installer

```bash
./install.sh
```

## What the Installer Does

The installer will:

1. Install the BasicConfig-Hyprland configuration.
2. Make Hyprland scripts executable.
3. Enable NetworkManager.
4. Enable Bluetooth.
5. Enable PipeWire and WirePlumber.
6. Initialize Matugen with the included wallpaper.
7. Reboot the system.

## Configuration Backup

Before installing the configuration, the installer creates a backup of existing configuration directories.

Your backup will be stored in a directory similar to:

```text
~/hypr_backup_20260826_190000/
```

The timestamp will be different depending on when you run the installer.

## After Installation

After the installer finishes, your system will automatically reboot.

Once you log back into Hyprland, the configuration should be loaded automatically.

## Updating the Configuration

To get the latest version of the configuration:

### 1. Enter the repository

```bash
cd BasicConfig-Hyprland
```

### 2. Pull the latest changes

```bash
git pull
```

### 3. Run the installer again

```bash
./install.sh
```

> **Warning:** Running the installer again will replace existing configuration files after creating a backup. Make sure you have saved any personal configuration changes before doing so.

thats it.
# EXAMPLES:
<img width="3840" height="1080" alt="2026-08-25_16-20-39" src="https://github.com/user-attachments/assets/94279bb8-c3cf-4386-9692-4ab2732e6e62" />
<img width="3840" height="1080" alt="2026-08-25_22-31-13" src="https://github.com/user-attachments/assets/169ea2f3-6128-4f94-9a30-5878fa9005f8" />
<img width="3840" height="1080" alt="2026-08-26_02-14-26" src="https://github.com/user-attachments/assets/69662bb7-abe0-444b-a023-dad6c37f46af" />
