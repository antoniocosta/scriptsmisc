#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Export all artboards for all .sketch files found in a folder, for quick preview."
	echo "usage: ./sketchpreview.sh folder"
	exit 1
fi


find "$1" -name "*.sketch" | while read SKETCH ; do 

DIR="$(dirname "$SKETCH")" ; # Only the path
FILE="$(basename "$SKETCH")" ; # Filename with extension
F="${FILE%.*}" ; # filename without extension
EXT="${FILE##*.}" ; # extension

NEWDIR="$DIR/$F Artboards" ;

if [ -d "$NEWDIR" ]
then
    echo "# Skipped $FILE"
else
	echo "# Exporting $FILE" ;
	mkdir -pv "$NEWDIR" ; # create a folder to hold all PNGs
	sketchtool export artboards --output="$NEWDIR" "$SKETCH"
fi
done

echo "# All Done!" ;