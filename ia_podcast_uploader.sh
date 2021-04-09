#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Uploads a podcast file to the Internet Archive"
	echo "usage: ./ia_podcast_uploader.sh [podcast 2 digit num]"
	exit 1
fi

# The number of the episode passed from command line
NUM=$1
IDENTIFIER="abmc-sd_podcast_$NUM"
#PATH_MP3="/Volumes/home/my_sites/live_static/www.specialdefects.com/podcast/media/abmc-sd_podcast_$NUM.mp3"
#PATH_MP3="/Volumes/home/my_docs/my_work/specialdefects.com_podcast/_audio/abmc-sd_podcast_$NUM.mp3"
PATH_MP3="/Volumes/Macintosh HD/Users/abmc/Downloads/sd_podcast_media/abmc-sd_podcast_$NUM.mp3"
PATH_PNG="/Volumes/home/my_sites/live_static/www.specialdefects.com/podcast/$NUM/podcast.png"
PATH_XML="/Volumes/home/my_sites/live_static/www.specialdefects.com/podcast/$NUM/podcast.xml"
TITLE="Special Defects Podcast #$NUM"
DATE=`xmllint $PATH_XML --xpath "//item/date/text()"`
DATE=`date -j -f "%Y/%m/%d %H:%M %Z" "$DATE" "+%F"`
LENGTH=`xmllint $PATH_XML --xpath "//item/length/text()"`
DESC=`xmllint $PATH_XML --xpath "//item/desc/text()"`
PLAYLIST=`xmllint $PATH_XML --xpath "//item/playlist/text()"`
#DESC_FULL=$DESC$' : <br/><br/>'$PLAYLIST

ia --debug upload $IDENTIFIER "$PATH_MP3" "$PATH_PNG" --retries 100 --metadata="mediatype:audio" --metadata="title:$TITLE" --metadata="date:$DATE" --metadata="length:$LENGTH" --metadata="author:abmc" --metadata="description:$DESC" --metadata="playlist:$PLAYLIST" --metadata="subject:specialdefects; podcast" --metadata="collection:opensource_audio"
