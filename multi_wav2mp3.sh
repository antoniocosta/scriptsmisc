#!/bin/sh

# Converts all wav files to mp3 using ffmpeg

for i in *.wav ; do 
    ffmpeg -i "$i" -ab 320k -map_metadata 0 -id3v2_version 3 "$(basename "${i/.wav}").mp3"
done
