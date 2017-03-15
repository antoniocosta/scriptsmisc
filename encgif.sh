#!/bin/sh

if [ $# -eq 0 ]; then
	echo "Converts video to animated gif."
	echo "usage: ./encgif.sh video [width] [fps]"
	exit 1
fi

# Use $2 if defined AND NOT EMPTY otherwise use 320 width
WIDTH=${2-320} 
# Use $3 if defined AND NOT EMPTY otherwise use 15 fps
FPS=${3-15} 
# Use same filename for .gif
OUTPUT=$(echo $1 | cut -f 1 -d '.').gif

PALETTE="/tmp/palette.png"
FILTERS="fps=$FPS,scale=$WIDTH:-1:flags=lanczos"

echo "Converting..."
ffmpeg -v warning -i "$1" -vf "$FILTERS,palettegen" -y $PALETTE
ffmpeg -v warning -i "$1" -i $PALETTE -lavfi "$FILTERS [x]; [x][1:v] paletteuse" -y "$OUTPUT"
echo "DONE!"
