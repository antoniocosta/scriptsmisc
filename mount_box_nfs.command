#!/bin/sh

# LAN script. Mount box home via nfs on desktop

mkdir ~/Desktop/nfs
sudo mount -t nfs -o resvport box.local:/volume1/homes/abmc ~/Desktop/nfs
