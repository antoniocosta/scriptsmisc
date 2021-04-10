#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Export all artboards for all .sketch files found in a folder, for quick preview."
	echo "usage: ./sketchexport.sh file.sketch"
	exit 1
fi


## find "$1" -name "*.sketch" | while read SKETCH ; do

## DIR="$(dirname "$SKETCH")" ; # Only the path
## FILE="$(basename "$SKETCH")" ; # Filename with extension

DIR="$(dirname "$1")" ; # Only the path
FILE="$1" ; # Filename with extension

F="${FILE%.*}" ; # filename without extension
EXT="${FILE##*.}" ; # extension

NEWDIR="$DIR/$F Artboards" ;

if [ -d "$NEWDIR" ]
then
    echo "# Skipped $FILE"
else
	echo "# Exporting $FILE" ;
	mkdir -pv "$NEWDIR" ; # create a folder to hold all PNGs
	/Applications/Sketch.app/Contents/Resources/sketchtool/bin/sketchtool export artboards --output="$NEWDIR" "$FILE"
fi

###for artboard in "$NEWDIR/*.png"; do
###    mv ${artboard} "${sketchFile%.sketch}_$(basename ${artboard})"
###done

## done

echo "# All Done!" ;
