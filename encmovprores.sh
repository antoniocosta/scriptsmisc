#!/bin/sh

if [ $# -eq 0 ]; then
	echo "Converts video to mov (ProRes)"
	echo "usage: ./ench264.sh video [quality]"
	echo "[quality] defaults to 3 (HQ). Accepted 0-3. Higher values are better quality."
	echo "          0 is Proxy, 1 is LT, 2 is Standard and 3 is HQ"
	exit 1
fi

# Use $2 if defined AND NOT EMPTY otherwise use 2
QUALITY=${2-3}
# Use same filename for .mp4
OUTPUT=$(echo $1 | cut -f 1 -d '.')_prores.mov

echo "Converting..."

ffmpeg -i "$1" -vcodec prores -profile 4 "$OUTPUT"
echo "DONE!"
