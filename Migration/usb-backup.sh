#!/bin/bash

# USB Slot Backup by Xan#7777

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

# Prerequisites
clear
echo "Creating necessary folders..."
    mkdir -p "$HOME"/backup
    mkdir -p "$HOME"/backup/apps
    mkdir -p "$HOME"/backup/extras

cd "$HOME" || exit

# Backup proper
clear
echo "You have backed up the following apps:" > "$HOME"/backup/backup-list.txt
echo "" >> "$HOME"/backup/backup-list.txt

if [ -n "$(ls -A "$HOME"/.config/airsonic 2>/dev/null)" ] && [ -n "$(ls -A "$HOME"/.apps/airsonic 2>/dev/null)" ];
then
    echo "Backing up Airsonic..."
    app-airsonic stop
    tar -cvf "$HOME"/backup/apps/airsonic.tar .config/airsonic/ .apps/airsonic/
    app-airsonic start
    echo "Airsonic" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.autodl 2>/dev/null)" ];
then
    echo "Backing up autodl..."
    app-autodl-irssi stop
    tar -cvf "$HOME"/backup/apps/autodl-irssi.tar .autodl/
    app-autodl-irssi start
    echo "AutoDL-irssi" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/bazarr 2>/dev/null)" ];
then
    echo "Backing up Bazarr..."
    app-bazarr stop
    tar -cvf "$HOME"/backup/apps/bazarr.tar .apps/bazarr/
    app-bazarr start
    echo "Bazarr" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/btsync 2>/dev/null)" ];
then
    echo "Backing up Resilio Sync..."
    app-btsync stop
    tar -cvf "$HOME"/backup/apps/btsync .apps/btsync/
    app-btsync start
    echo "Resilio Sync" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/couchpotato 2>/dev/null)" ];
then
    echo "Backing up CouchPotato..."
    app-couchpotato stop
    tar -cvf "$HOME"/backup/apps/couchpotato .apps/couchpotato/
    app-couchpotato start
    echo "CouchPotato" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/emby 2>/dev/null)" ];
then
    echo "Backing up Emby..."
    app-emby stop
    tar -cvf "$HOME"/backup/apps/emby .apps/emby/
    app-emby start
    echo "Emby" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/jackett 2>/dev/null)" ];
then
    echo "Backing up Jackett..."
    app-jackett stop
    tar -cvf "$HOME"/backup/apps/jackett .apps/jackett/
    app-jackett start
    echo "Jackett" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/jdownloader2 2>/dev/null)" ];
then
    echo "Backing up JDownloader2..."
    app-jdownloader2 stop
    tar -cvf "$HOME"/backup/apps/jdownloader2 .config/jdownloader2/
    app-jdownloader2 start
    echo "JDownloader2" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/jellyfin 2>/dev/null)" ];
then
    echo "Backing up Jellyfin..."
    app-jellyfin stop
    tar -cvf "$HOME"/backup/apps/jellyfin .apps/jellyfin/
    app-jellyfin start
    echo "Jellyfin" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/lazylibrarian 2>/dev/null)" ];
then
    echo "Backing up LazyLibrarian..."
    app-lazylibrarian stop
    tar -cvf "$HOME"/backup/apps/lazylibrarian .config/lazylibrarian/
    app-lazylibrarian start
    echo "LazyLibrarian" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/lidarr 2>/dev/null)" ];
then
    echo "Backing up Lidarr..."
    app-lidarr stop
    tar -cvf "$HOME"/backup/apps/lidarr .config/lidarr/
    app-lidarr start
    echo "Lidarr" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/medusa 2>/dev/null)" ];
then
    echo "Backing up Medusa..."
    app-medusa stop
    tar -cvf "$HOME"/backup/apps/medusa .apps/medusa/
    app-medusa start
    echo "Medusa" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/mylar 2>/dev/null)" ] && [ -n "$(ls -A "$HOME"/.config/mylar 2>/dev/null)" ];
then
    echo "Backing up Mylar..."
    app-mylar stop
    tar -cvf "$HOME"/backup/apps/mylar .apps/mylar/ .config/mylar/
    app-mylar start
    echo "Mylar" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/nzbget 2>/dev/null)" ];
then
    echo "Backing up nzbget..."
    app-nzbget stop
    tar -cvf "$HOME"/backup/apps/nzbget .config/nzbget/
    app-nzbget start
    echo "NZBGet" >>  "$HOME"/backup/backup-list.txt
elif [ -n "$(ls -A "$HOME"/.apps/nzbget 2>/dev/null)" ];
then
    echo "Backing up nzbget..."
    app-nzbget stop
    tar -cvf "$HOME"/backup/apps/nzbget .apps/nzbget/
    app-nzbget start
    echo "NZBGet" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/nzbhydra2 2>/dev/null)" ];
then
    echo "Backing up NZBHydra2..."
    app-nzbhydra2 stop
    tar -cvf "$HOME"/backup/apps/nzbhydra2 .config/nzbhydra2/
    app-nzbhydra2 start
    echo "NZBHydra2" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/ombi 2>/dev/null)" ];
then
    echo "Backing up Ombi..."
    app-ombi stop
    tar -cvf "$HOME"/backup/apps/ombi .config/ombi/
    app-ombi start
    echo "Ombi" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/plex 2>/dev/null)" ];
then
    echo "Backing up Plex..."
    app-plex stop
    tar -cvf "$HOME"/backup/apps/plex .config/plex/
    app-plex start
    echo "Plex" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/radarr 2>/dev/null)" ];
then
    echo "Backing up Radarr..."
    app-radarr stop
    tar -cvf "$HOME"/backup/apps/radarr .apps/radarr/
    app-radarr start
    echo "Radarr" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sabnzbd 2>/dev/null)" ];
then
    echo "Backing up SABnzbd..."
    app-sabnzbd stop
    tar -cvf "$HOME"/backup/apps/sabnzbd .apps/sabnzbd/
    app-sabnzbd start
    echo "SABnzbd" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sickchill 2>/dev/null)" ];
then
    echo "Backing up SickChill..."
    app-sickchill stop
    tar -cvf "$HOME"/backup/apps/sickchill .apps/sickchill/
    app-sickchill start
    echo "SickChill" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sonarr 2>/dev/null)" ];
then
    echo "Backing up Sonarr..."
    app-sonarr stop
    tar -cvf "$HOME"/backup/apps/sonarr .apps/sonarr/
    app-sonarr start
    echo "Sonarr" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/syncthing 2>/dev/null)" ];
then
    echo "Backing up Syncthing..."
    app-syncthing stop
    tar -cvf "$HOME"/backup/apps/syncthing .apps/syncthing/
    app-syncthing start
    echo "Syncthing" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/tautulli 2>/dev/null)" ];
then
    echo "Backing up Tautulli..."
    app-tautulli stop
    tar -cvf "$HOME"/backup/apps/tautulli .config/tautulli/
    app-tautulli start
    echo "Tautulli" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/transmission 2>/dev/null)" ];
then
    echo "Backing up Transmission..."
    app-transmission stop
    tar -cvf "$HOME"/backup/apps/transmission .apps/transmission/
    app-transmission start
    echo "Transmission" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/ubooquity 2>/dev/null)" ] && [ -n "$(ls -A "$HOME"/.config/ubooquity 2>/dev/null)" ];
then
    echo "Backing up Ubooquity..."
    app-ubooquity stop
    tar -cvf "$HOME"/backup/apps/ubooquity .apps/ubooquity/ .config/ubooquity/
    app-ubooquity start
    echo "Ubooquity" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/ubooquity 2>/dev/null)" ];
then
    echo "Backing up ZNC..."
    app-znc stop
    tar -cvf "$HOME"/backup/apps/znc .apps/znc/
    app-znc start
    echo "ZNC" >>  "$HOME"/backup/backup-list.txt
fi

{
echo ""
echo "Please save this folder in a safe location or run the migration script on this slot."
echo ""
echo "If you run the migration script, please make sure you have installed the apps listed above on the new slot first."
} >> "$HOME"/backup/backup-list.txt

clear
cat "$HOME"/backup/backup-list.txt
exit 