#!/bin/sh

pkill swaybg > /dev/null 2>&1
swaybg -i "$(find "${HOME}"/Pictures/bg/ -type f | shuf -n 1)" > /dev/null 2>&1 &
