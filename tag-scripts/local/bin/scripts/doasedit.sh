#!/bin/sh

doMySudoEdit() {
    rawFile=$1
    rawUid=$(stat -c %u "$1")
    rawGid=$(stat -c %g "$1")
    rawmode=$(stat -c %a "$1")
    random=$(/bin/md5sum < /proc/sys/kernel/random/uuid | /bin/cut -c 1-9)
    newFile="/var/tmp/${random}$(basename "$1")"

    /bin/cp "${rawFile}" "${newFile}"

    if diff "${newFile}" "${rawFile}" > /dev/null
    then
        /bin/vi "${newFile}"
    fi

    if ! diff "${newFile}" "${rawFile}" > /dev/null
    then
        /bin/doas /bin/chmod "${rawmode}" "${rawFile}"
        /bin/doas /bin/chown "${rawUid}" "${rawFile}"
        /bin/doas /bin/chgrp "${rawGid}" "${rawFile}"
        /bin/doas /bin/mv "${newFile}" "${rawFile}"
    else
        /bin/echo "do not change"
        /bin/rm "${newFile}"
    fi
}

MySudoEdit() {
    fileinfo=$(file "$1")
    if expr "${fileinfo}" : ".* text" > /dev/null; then
        doMySudoEdit "$1"
    else
        /bin/echo "usage: $(basename "$0") 'text file'"
    fi
}

if [ $# -eq 1 ];  then
    if [ -f "$1" ]; then
        MySudoEdit "$1"
    else
        /bin/echo "usage: $(basename "$0") 'text file'"
    fi
else
    /bin/echo "usage: $(basename "$0") 'text file'"
fi
