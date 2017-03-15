#!/bin/sh

if [ $# -eq 0 ]; then
	echo "Converts video to h264."
	echo "usage: ./ench264.sh video [quality]"
	echo "[quality] defaults to 18. Accepted 0-51. Lower values are better quality."
	exit 1
fi

# Use $2 if defined AND NOT EMPTY otherwise use 18 
QUALITY=${2-18} 
# Use same filename for .webm
OUTPUT=$(echo $1 | cut -f 1 -d '.').mp4

echo "Converting..."
ffmpeg -i "$1" -c:v libx264 -crf "$QUALITY" "$OUTPUT"
echo "DONE!"
