#!/usr/bin/env bash
WALL_DIR="$HOME/.config/niri/walls"
CACHE_DIR="$HOME/.cache/hyprlock"
BG_FILE="$CACHE_DIR/hyprlock_bg.conf"

mkdir -p "$CACHE_DIR"

RANDOM_WALL=$(ls "$WALL_DIR"/*.{jpg,jpeg,png,webp} 2>/dev/null | shuf -n1)
USER_FACE="/usr/share/sddm/faces/$USER.face.icon"

cat > "$BG_FILE" << EOF
general {
    disable_loading_bar = true
    grace = 0
    hide_cursor = true
    no_fade_in = false
}

background {
    monitor =
    path = $RANDOM_WALL
    blur_passes = 2
    blur_size = 8
}

image {
    monitor =
    path = $USER_FACE
    size = 80
    border_radius = 40
    position = 0, 40
    halign = center
    valign = center
}

label {
    monitor =
    text = cmd[update:1000] echo "$(date '+%H:%M')"
    color = rgba(255, 255, 255, 0.9)
    font_size = 50
    font_family = JetBrainsMono Nerd Font
    position = 0, -120
    halign = center
    valign = center
}

label {
    monitor =
    text = cmd[update:1000] echo "$(date '+%A, %B %d, %Y')"
    color = rgba(255, 255, 255, 0.9)
    font_size = 14
    font_family = JetBrainsMono Nerd Font
    position = 0, -180
    halign = center
    valign = center
}

input-field {
    monitor =
    size = 200, 30
    outline_thickness = 2
    dots_size = 0.33
    dots_spacing = 0.15
    dots_center = true
    outer_color = rgba(255, 255, 255, 0.3)
    inner_color = rgba(255, 255, 255, 0.15)
    font_color = rgba(255, 255, 255, 0.8)
    fade_on_empty = false
    placeholder_text = <i></i>
    hide_input = false
    rounding = 10
    check_color = rgb(7fc8ff)
    fail_color = rgb(9b0000)
    fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
    capslock_color = rgb(9b0000)
    position = 0, -40
    halign = center
    valign = center
}
EOF
