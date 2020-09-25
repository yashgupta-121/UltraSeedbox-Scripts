#!/bin/bash

# USB Migration Slot by Xan#7777

# Unofficial Script warning
clear
echo "This is the USB Backup Tool!"
echo ""
printf "\033[0;31mDisclaimer: This script is unofficial and USB staff will not support any issues with it\033[0m\n"
read -rp "Type confirm if you wish to continue: " input
if [ ! "$input" = "confirm" ]
then
    exit
fi

# Torrent checks
