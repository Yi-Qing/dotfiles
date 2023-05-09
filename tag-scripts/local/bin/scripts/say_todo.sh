#!/bin/sh

TODO_FILE=${HOME}/.local/share/todo/todo.say

TODO_LINE=$(cat < "${TODO_FILE}" | wc -l)

if [ "${TODO_LINE}" -ne 0 ]; then
	cat < "${TODO_FILE}" | cowthink -f koala | lolcat
fi
