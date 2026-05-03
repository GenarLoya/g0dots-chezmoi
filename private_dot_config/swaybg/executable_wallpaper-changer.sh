#!/usr/bin/env bash

WALLDIR="$HOME/.config/swaybg"

if ! command -v swaybg &> /dev/null; then
    echo "swaybg not found"
    exit 1
fi

# Kill existing swaybg
pkill swaybg 2>/dev/null

# Get random wallpaper
WALL=$(find "$WALLDIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | shuf -n 1)

if [ -z "$WALL" ]; then
    echo "No wallpapers found in $WALLDIR"
    exit 1
fi

echo "Setting wallpaper: $WALL"
swaybg -i "$WALL" -m fill &

echo "swaybg started with wallpaper: $WALL"