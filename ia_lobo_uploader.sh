#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Uploads an mp3 recorded file to the Internet Archive"
	echo "usage: ./ia_lobo_uploader.sh [mp3 file]"
	exit 1
fi

FILE="$1" # full path to mp3 file
FILENAME="${FILE##*/}"  # get filename
DIRNAME="${FILE%/*}" # get directory/path name
EXTENSION="${FILENAME##*.}" # get file extension
NAME="${FILENAME%.*}" # get filename without extension
IFS='_' read -r -a array <<< "$NAME" # split string into array using a delimiter char
DATE="${array[0]}" # get date YYYMMDDD
DATE=`echo $DATE | sed -n -e "s_\(....\)\(..\)\(..\)_\1-\2-\3_p"` # format date YYYY-MM-DD

PROG="${array[1]}" # program name
if [ "$PROG" == 'horadolobo' ]
then PROG='A Hora do Lobo'
elif [ "$PROG" == 'ashoras' ]
then PROG='As Horas'
elif [ "$PROG" == 'viriato25' ]
then PROG='Viriato 25'
fi

RADIO="${array[2]}" # radio name
if [ "$RADIO" == 'comercial' ]
then RADIO='Rádio Comercial, Portugal'
elif [ "$RADIO" == 'bestrock' ]
then RADIO='Best Rock FM, Portugal'
elif [ "$RADIO" == 'radar' ]
then RADIO='Rádio Radar, Portugal'
fi

BITRATE="${array[3]}" # bitrate

#echo 'DIRNAME = '$DIRNAME
#echo 'FILENAME = '$FILENAME
#echo 'EXTENSION = '$EXTENSION
#echo 'NAME = '$NAME
#echo 'DATE = '$DATE
#echo 'PROG = '$PROG
#echo 'RADIO = '$RADIO
#echo 'BITRATE = '$BITRATE

PATH_MP3="$FILE"
PATH_IMG='/Users/abmc/Downloads/antoniosergio/img/antoniosergio.jpg'

IDENTIFIER=$NAME
MEDIATYPE='audio'
TITLE="$PROG com António Sérgio ($DATE)"
COLLECTION='opensource_audio'
DESCRIPTION='António Sérgio Correia Ferrão (14 Jan 1950 - 1 Nov 2009) foi um locutor e realizador de rádio português, DJ, editor discográfico, especialista e grande divulgador de música rock, pop e de vanguarda. -- <a href="https://pt.wikipedia.org/wiki/Ant%C3%B3nio_S%C3%A9rgio_(radialista)">Wikipedia</a>'
NOTES='Gravação integral de uma das emissões do programa de rádio do mítico radialista António Sérgio. Realizada para uso particular por entusiasta do autor, agora aqui arquivada, imortalizada e ao alcance de todos.'
CONTRIBUTOR="António Costa"
CREATOR='António Sérgio'
SOURCE=$RADIO
SUBJECT='antoniosergio; radio; portugal; music; alternative'
DATE=$DATE
LANGUAGE='por'
LICENSEURL='http://creativecommons.org/licenses/by-nc-sa/4.0/'
AUDIO_CODEC='mp3'
BITRATE="$BITRATE kbps"

#
# COMMAND LINE TOOL: https://archive.org/services/docs/api/internetarchive/cli.html
#

ia --log --insecure upload $IDENTIFIER "$PATH_IMG" "$PATH_MP3" --retries 120 \
--metadata="mediatype:$MEDIATYPE" \
--metadata="title:$TITLE" \
--metadata="collection:$COLLECTION" \
--metadata="description:$DESCRIPTION" \
--metadata="notes:$NOTES" \
--metadata="contributor:$CONTRIBUTOR" \
--metadata="creator:$CREATOR" \
--metadata="source:$SOURCE" \
--metadata="subject:$SUBJECT" \
--metadata="date:$DATE" \
--metadata="language:$LANGUAGE" \
--metadata="licenseurl:$LICENSEURL" \
--metadata="audio_codec:$AUDIO_CODEC" \
--metadata="bitrate:$BITRATE"

#
# ITEM FILES API (S3 LIKE): https://archive.org/services/docs/api/ias3.html#
#

#S3ACCESSKEY='yqt1YXpoaleYXXx1'
#S3SECRETKEY='lNoPDdcoIL1JF9P0'

#curl --location --header "x-amz-auto-make-bucket:1" \
#     --header "x-archive-meta-mediatype:$MEDIATYPE" \
#		 --header "x-archive-meta-title:$TITLE" \
#		 --header "x-archive-meta01-collection:$COLLECTION" \
#		 --header "x-archive-meta-description:$DESCRIPTION" \
#		 --header "x-archive-meta-notes:$NOTES" \
#		 --header "x-archive-meta-contributor:$CONTRIBUTOR" \
#		 --header "x-archive-meta-creator:$CREATOR" \
#		 --header "x-archive-meta-source:$SOURCE" \
#		 --header "x-archive-meta-subject:$SUBJECT" \
#		 --header "x-archive-meta-date:$DATE" \
#		 --header "x-archive-meta-language:$LANGUAGE" \
#		 --header "x-archive-meta-licenseurl:$LICENSEURL" \
#		 --header "x-archive-meta-audio_codec:$AUDIO_CODEC" \
#		 --header "x-archive-meta-bitrate:$BITRATE" \
#     --header "authorization: LOW $S3ACCESSKEY:$S3SECRETKEY" \
#     --upload-file "$PATH_MP3" \
#     "http://s3.us.archive.org/$IDENTIFIER/$FILENAME"

#curl --location \
#    --header "authorization: LOW $S3ACCESSKEY:$S3SECRETKEY" \
#    --upload-file "$PATH_IMG" \
#    "http://s3.us.archive.org/$IDENTIFIER/antoniosergio.jpg"
