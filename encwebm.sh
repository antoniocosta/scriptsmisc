#!/bin/sh

if [ $# -eq 0 ]; then
	echo "Converts video to webm."
	echo "usage: ./encwebm.sh video [bitrate] [quality]"
	echo "[bitrate] defaults to 10M (or 10000k)"
	echo "[quality] defaults to 10. Accepted 0-63. Lower values are better quality"
	exit 1
fi

# Use $2 if defined AND NOT EMPTY otherwise use 320 width
BITRATE=${2-10M} 
# Use $3 if defined AND NOT EMPTY otherwise use 10 
QUALITY=${3-10} 
# Use same filename for .webm
OUTPUT=$(echo $1 | cut -f 1 -d '.').webm


echo "Converting..."
ffmpeg -i "$1" -c:v libvpx -pix_fmt yuva420p -b:v "$BITRATE" -crf "$QUALITY" "$OUTPUT"
echo "DONE!"
