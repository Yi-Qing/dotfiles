#!/bin/sh

OLDIFS=${IFS}
IFS="
"

WORKDIR=$(pwd)

if [ $# -ne 0 ];	then
	WORKDIR=$1
fi

ERROR_LINKS=$(find "${WORKDIR}" -xtype l)

for f in ${ERROR_LINKS}
do
	echo "rm \"${f}\""
	/bin/rm "${f}"
done

IFS=${OLDIFS}
