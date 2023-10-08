#!/bin/sh

TODO_FILE=${HOME}/.local/share/todo/todo.say

do_say_todo(){
	TODO_LINE=$(cat < "${TODO_FILE}" | wc -l)

	if [ "${TODO_LINE}" -ne 0 ]; then
        printf "\e[3;38;2;62;237;231m"
		cat < "${TODO_FILE}" | cowthink -f koala -n # | lolcat
        printf "\e[0m\n"
	fi
}

[ -e "${TODO_FILE}" ] && do_say_todo
