#!/bin/sh

if [ $# -eq 0 ]; then
	echo "Converts image sequence to mp4"
	echo "usage: ./encimgseq.sh image.png [fps]"
	exit 1
fi

# Use $3 if defined AND NOT EMPTY otherwise use 15 fps
FPS=${2-15}
# Use same filename for .mp4
INPUT=$(echo $1 | cut -f 1 -d '.')%04d.png
OUTPUT=$(echo $1 | cut -f 1 -d '.').mp4

echo "Converting..."
ffmpeg -v warning -r "$FPS" -f image2 -i "$INPUT" -vcodec libx264 -crf 25 -pix_fmt yuv420p "$OUTPUT"
#ffmpeg -v warning -r "$FPS" -f image2 -s 1280x720 -i $(echo $1 | cut -f 1 -d '.').png -vcodec libx264 -crf 25 -pix_fmt yuv420p "$OUTPUT"
echo "DONE!"
