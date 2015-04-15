#!/bin/bash

DATE=`date "+%Y-%m-%d at %H.%M.%S"`
FILENAME="Screen Recording "$DATE".mp4"
ADB=`command -v adb`

#$ADB shell screenrecord --verbose "/sdcard/$FILENAME" &
$ADB shell screenrecord "/sdcard/$FILENAME" &

PID_REC=$!

echo "Recording. Press any key to stop..."
read -p ""

echo "Stopping."
kill -6 $PID_REC

sleep 2

echo "Copying file to desktop..."
$ADB pull "/sdcard/$FILENAME" "$HOME/Desktop/$FILENAME"

echo "Deleting file from device..."
$ADB shell rm -r "/sdcard/$FILENAME"

echo "Launching QuickTime Player..."
open -a "/Applications/QuickTime Player.app" "$HOME/Desktop/$FILENAME"

echo "Finished."
osascript -e 'tell application "Terminal" to close (every window whose name contains "androidToQuicktime.command")' &
exit
