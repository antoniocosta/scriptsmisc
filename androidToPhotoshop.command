#!/bin/bash

DATE=`date "+%Y-%m-%d at %H.%M.%S"`
FILENAME="Screen Shot "$DATE".png"
ADB=`command -v adb`

$ADB shell screencap -p "/sdcard/$FILENAME"

echo "Copying file to desktop..."
$ADB pull "/sdcard/$FILENAME" "$HOME/Desktop/$FILENAME"

echo "Deleting file from device..."
$ADB shell rm -r "/sdcard/$FILENAME"

echo "Launching Photoshop CC..."
open -a "/Applications/Adobe Photoshop CC 2014/Adobe Photoshop CC 2014.app" "$HOME/Desktop/$FILENAME"

echo "Finished."
osascript -e 'tell application "Terminal" to close (every window whose name contains "androidToPhotoshop.command")' &
exit
