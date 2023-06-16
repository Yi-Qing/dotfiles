#!/usr/bin/env bash

TODO_DIRS="${HOME}/.local/share/todo"

[ ! -d "${TODO_DIRS}" ] && mkdir -p "${TODO_DIRS}"

vim "${TODO_DIRS}"/todo.say
