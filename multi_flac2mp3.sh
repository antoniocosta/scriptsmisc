#!/bin/sh

# Converts all flac files to mp3 using ffmpeg

for i in *.flac ; do 
    ffmpeg -i "$i" -ab 320k -map_metadata 0 -id3v2_version 3 "$(basename "${i/.flac}").mp3"
done
