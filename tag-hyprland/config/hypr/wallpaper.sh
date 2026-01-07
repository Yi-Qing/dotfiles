#!/bin/sh

file="${HOME}/.config/hypr/hyprpaper.conf"
if [ ! -d "${HOME}/Pictures/bg/" ]; then
    echo "Error: Directory ${HOME}/Pictures/bg/ does not exist"
    exit 1
fi

wallpaper=$(find "${HOME}"/Pictures/bg/ -type f | shuf --random-source=/dev/urandom -n 1)

cat > "$file" << EOF
ipc = false
splash = false
wallpaper {
    monitor =
    path = $wallpaper
}
EOF

hyprpaper &
