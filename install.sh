#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

echo "==> Installing stow..."
if command -v pacman &>/dev/null; then
    sudo pacman -S --needed stow
fi

echo "==> Entering dotfiles directory..."
cd "$DOTFILES"

stow --adopt */
git restore .