#!/bin/bash

now="$(date +'周%a %F %T' && colunar | head -n 3 | grep -v '阳历')"

mapfile -t stringarray <<< "$now"
IFS=" " read -r -a time_array <<< "${stringarray[0]}"

TEXT="${time_array[2]}"
ALT="${time_array[1]}"
TOOLTIP="${stringarray[1]//生肖/}\\n${stringarray[2]}"

printf '{"text": "%s", "alt": "%s", "tooltip": "%s"}\n' "$TEXT" "$ALT" "$TOOLTIP"
