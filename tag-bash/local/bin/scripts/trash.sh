#!/bin/sh

TRASHDIR=${HOME}/.cache/trash_recycle
TRASHDB=${TRASHDIR}/.mytrashdb
# OLDIFS=$IFS

if [ ! -d "$TRASHDIR" ]
then
	echo "mkdir ${TRASHDIR}"
	/bin/mkdir "$TRASHDIR"
fi

doFileTrash()
{
   	if ! expr "$1" : "^\/.*" > /dev/null;	then
		# if file path is not absolute path, add prefix: "./"
		dir=$(dirname "./${1}")
	else
		dir=$(dirname "${1}")
	fi
	cd "${dir}" || exit
	dir=$(pwd)
	cd - > /dev/null || exit
	var=$(basename "${dir}/${1}")

	if [ "$N" -eq 0 ];	then
		rm_file="${var}"
	else
		rm_file="${var%_*}"
	fi

	if [ ! -e "${TRASHDIR}/${var}" ];	then
		if [ ! -e "${dir}/${rm_file}" ];	then
			echo "${dir}/${rm_file} not exist"
		else
			/bin/mv -i "${dir}/${rm_file}" "${TRASHDIR}"/"${var}"
			if [ -e "${TRASHDIR}/${var}" ];	then
			 	timeStr=$(date +%F_%T)
				echo "${timeStr}|${var}|${dir}/${rm_file}" >> "${TRASHDB}"
			fi
		fi
	else
		N=$((N + 1))
		doFileTrash "${dir}/${rm_file}_${N}"
	fi
}

trashFile()
{
	IFS='
'
	for var in $@
	do
		N=0
		doFileTrash "${var}"
	done
	IFS=$OLDIFS
}

recoverTrashFile()
{
	IFS='
'
	for var in $@
	do
		var=$(basename "${var}")
		restore=$(grep "${var}|" < "${TRASHDB}" | cut -d "|" -f 3)
		echo "recover \"${var}\" to \"${restore}\""

		if [ ! -e "${TRASHDIR}/${var}" ];	then
			echo "${TRASHDIR}/${var} not exist"
		else
			/bin/mv -i "${TRASHDIR}/${var}" "${restore}"
			if [ ! -e "${TRASHDIR}/${var}" ];	then
				var="${var}|"
				sed -i "/${var}/d" "${TRASHDB}"
			fi
		fi
	done
	IFS=$OLDIFS
}

trashFileClean()
{
	IFS='
'
	all_files=$(ls -A "${TRASHDIR}")
	for rm_files in ${all_files}
	do
		if [ -e "${TRASHDIR}/${rm_files}" ];	then
			echo "clean $(basename "${TRASHDIR}/${rm_files}")"
			/bin/rm -rf "${TRASHDIR:?}/${rm_files}"
		elif [ -L "${TRASHDIR}/${rm_files}" ];	then
			echo "clean $(basename "${TRASHDIR}/${rm_files}")"
			/bin/rm -rf "${TRASHDIR:?}/${rm_files}"
		fi
	done
	IFS=$OLDIFS
}

print_help() {
	echo "usage: 'trash.sh filenames(which you want trash)'"
	echo
	echo "	-h  for help"
	echo "	-r  for restore deleted file"
	echo "	-l  for list deleted file"
	echo "	-c  for clean recycle bin"
	echo
}

parse_parameters() {
	for var in "$@"
	do
    	if ! expr "$var" : "^-.$" > /dev/null;
		then
        	files="$files
$var"
		else
        	param="$param $var"
		fi
	done

	param_cnt=$(echo "$param" | grep -o ' -.' | wc -l)
	if [ "$param_cnt" -gt 1 ];	then
		echo "error options count, only support one option"
	elif [ "$param" = " -h" ];	then
		print_help
	elif [ "$param" = " -l" ];	then
		# /bin/ls -A --color=auto "${TRASHDIR}"
		if [ -e "${TRASHDB}" ];	then
			/bin/column -t -s "|" -N TIME,FILE,DIST -E FILE -T FILE,DIST < "${TRASHDB}"
		else
			/bin/echo "trash dir is empty"
		fi
	elif [ "$param" = " -r" ];	then
	 	if [ "$#" -lt 2 ];	then
	 		echo "useage: $0 $1 filename"
	 	else
	 		# shift	# drop $1
	 		recoverTrashFile "$files"
	 	fi
	elif [ "$param" = " -c" ]; then
		trashFileClean
	elif [ "$param_cnt" -eq 0 ];	then
		trashFile "$files"
	else
		echo "error options: $param"
		print_help
	fi
}

if [ "$#" -eq 0 ]; then
	print_help
else
	parse_parameters "$@"
fi
