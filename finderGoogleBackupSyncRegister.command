#!/bin/sh

# FinderSync Extension to register and unregister Google's Finder Backup and Sync extension
# from Extensions (in System preference) programmatically using pluginkit on the shell (.sh script).
# Used to get around the bug where finder contextual menus disappear.

# Add it to DB.
echo "Adding plugin to DB."
pluginkit -a  "/Applications/Backup and Sync.app/Contents/PlugIns/FinderSyncAPIExtension.appex"
# Enable it
echo "Enabling plugin."
pluginkit -e use -i com.google.GoogleDrive.FinderSyncAPIExtension

echo "Finished."
osascript -e 'tell application "Terminal" to close (every window whose name contains "finderGoogleBackupSyncRegister.command")' &
exit
