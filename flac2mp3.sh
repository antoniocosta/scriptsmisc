#!/bin/sh

for i in *.flac ; do 
    ffmpeg -i "$i" -ab 320k -map_metadata 0 -id3v2_version 3 "$(basename "${i/.flac}").mp3"
done
