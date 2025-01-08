#!/usr/bin/env bash

module_file_path = $1
$exercises_folder = $2


if [[ -e "$module_file_path"]]; then
    module_filename = $(filename() module_file_path)
    module_file_lines = ('cat "module_file_path")
else
    echo "Module file ${module_file_path}" does not exist
fi

function filename {
    module_filename=$(basename -- "$1")
    extension="${module_filename##*.}"
    filename="${module_filename%.*}"
}

if [ -d foo ] || mkdir $exercises_folder/module_filename


