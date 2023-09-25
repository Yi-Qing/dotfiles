#!/bin/sh

TODO_FILE=${HOME}/.local/share/todo/todo.say

do_say_todo(){
	TODO_LINE=$(cat < "${TODO_FILE}" | wc -l)

	if [ "${TODO_LINE}" -ne 0 ]; then
		cat < "${TODO_FILE}" | cowthink -f koala -n # | lolcat
	fi
}

[ -e "${TODO_FILE}" ] && do_say_todo
