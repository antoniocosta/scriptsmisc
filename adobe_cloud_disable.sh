#!/bin/sh

# See: https://gist.github.com/andreibosco/59aa0cca1e3f03aa5a3d4c79eb1f750c

# Disable adobe creative cloud:
launchctl unload -w /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist

# To re-enable run it like this:
# launchctl load -w /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist

# Run this command to figure out what the exact file/service name is on your computer: launchctl list | grep adobe
# Then disable all of them:
launchctl unload -w /Library/LaunchAgents/com.adobe.accmac.22644
launchctl unload -w /Library/LaunchAgents/com.adobe.GC.AGM
launchctl unload -w /Library/LaunchAgents/com.adobe.GC.Scheduler-1.0
launchctl unload -w /Library/LaunchAgents/com.adobe.ARMDCHelper.cc24aef4a1b90ed56a725c38014c95072f92651fb65e1bf9c8e43c37a23d420d
launchctl unload -w /Library/LaunchAgents/com.adobe.AAM.Scheduler-1.0
launchctl unload -w /Library/LaunchAgents/com.adobe.CCXProcess.22648
