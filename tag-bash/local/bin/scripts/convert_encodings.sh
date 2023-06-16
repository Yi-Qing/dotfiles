#!/bin/sh

recode_file()
{
    fileinfo=$(file "$1")
    if expr "${fileinfo}" : ".* text.*" > /dev/null; then
        echo "Recode file: $1"
        dos2unix -q "$1"
        if ! expr "${fileinfo}" : ".*UTF-8.*" > /dev/null; then
            iconv -f gb18030 -t utf8 "$1" -o tmp
            mv tmp "$1"
        fi
    fi
}

recode_dir()
{
    for var in "$1"/*
    do
        if [ -d "${var}" ]; then
            recode_dir "${var}"
        elif [ -f "${var}" ];    then
            recode_file "${var}"
        fi
    done
}

if [ $# != 1 ]; then
    echo "useage: $0 dir/file"
else
    if [ -d "$1" ]; then
        recode_dir "$(basename "$1")"
    elif [ -f "$1" ]; then
        recode_file "$1"
    else
        echo "OOP~~~ $1 not is a dir or a file"
    fi
fi
