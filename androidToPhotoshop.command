#!/bin/bash

# Shell script for OSX to screengrab from and Android device, save PNG to desktop and open in Photoshop.
# (Before using make sure adb is installed and developer mode & USB debugging are enabled on Android device)

DATE=`date "+%Y-%m-%d at %H.%M.%S"`
FILENAME="Screen Shot "$DATE".png"
FILENAME_ESCAPED=$(printf %q "$FILENAME")
ADB=`command -v adb`

$ADB shell screencap -p "/sdcard/$FILENAME_ESCAPED"

echo "Copying file to desktop..."
$ADB pull "/sdcard/$FILENAME" "$HOME/Desktop/$FILENAME"

echo "Deleting file from device..."
$ADB shell rm -r "/sdcard/$FILENAME_ESCAPED"

echo "Launching Photoshop CC..."
open -a "/Applications/Adobe Photoshop CC 2015.5/Adobe Photoshop CC 2015.5.app" "$HOME/Desktop/$FILENAME"

echo "Finished."
osascript -e 'tell application "Terminal" to close (every window whose name contains "androidToPhotoshop.command")' &
exit
