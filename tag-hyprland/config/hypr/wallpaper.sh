#!/bin/sh

wallpaper=$(find "${HOME}"/Pictures/bg/ -type f | shuf --random-source=/dev/urandom -n 1)
echo "ipc = off" > ~/.config/hypr/hyprpaper.conf
echo "preload = $wallpaper" >> ~/.config/hypr/hyprpaper.conf
echo "wallpaper = ,$wallpaper" >> ~/.config/hypr/hyprpaper.conf
hyprpaper &
