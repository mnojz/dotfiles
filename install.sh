#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

echo "==> Installing stow..."
if command -v pacman &>/dev/null; then
    sudo pacman -S --needed stow
elif command -v apt &>/dev/null; then
    sudo apt update && sudo apt install -y stow
elif command -v dnf &>/dev/null; then
    sudo dnf install -y stow
else
    echo "Unsupported package manager"
    exit 1
fi

echo "==> Entering dotfiles directory..."
cd "$DOTFILES"

# Packages you manage with stow
TARGETS=(
    "dolphin"
    "fastfetch"
    "fish"
    "hyprland"
    "imv"
    "kdeglobals"
    "kdenlive"
    "kitty"
    "mimeapps"
    "mousepad"
    "mpv"
    "nvim"
    "qt5ct"
    "qt6ct"
    "scripts"
    "starship"
    "thunar"
    "zed"
)

echo "==> Backing up conflicting configs (if any)..."

for pkg in "${TARGETS[@]}"; do
    target_dir="$HOME/.config/$pkg"

    echo "-> checking $pkg"

    # If it's a REAL directory/file (not symlink), back it up
    if [ -e "$target_dir" ] && [ ! -L "$target_dir" ]; then
        echo "   backing up real config: $target_dir -> $target_dir.backup"
        mv "$target_dir" "$target_dir.backup"
    fi

    # Handle flat files in ~/.config (not directories)
    for ext in conf toml list; do
        f="$HOME/.config/${pkg}.${ext}"
        if [ -e "$f" ] && [ ! -L "$f" ]; then
            echo "   backing up file: $f -> $f.backup"
            mv "$f" "$f.backup"
        fi
    done
done

echo "==> Applying stow..."

# safer than plain stow
stow -R */

echo "==> Done!"