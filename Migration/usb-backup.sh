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

# Backup proper
clear
echo "You have backed up the following apps:" > "$HOME"/backup/backup.txt
echo "" >> "$HOME"/backup/backup.txt

if [ -n "$(ls -A "$HOME"/.config/airsonic)" ] && [ -n "$(ls -A "$HOME"/.apps/airsonic)" ];
then
    echo "Backing up Airsonic..."
    app-airsonic stop
    tar -cvf "$HOME"/apps/airsonic.tar "$HOME"/.config/airsonic/ "$HOME"/.apps/airsonic/
    app-airsonic start
    echo "Airsonic" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.autodl)" ];
then
    echo "Backing up autodl..."
    app-autodl-irssi stop
    tar -cvf "$HOME"/apps/autodl-irssi.tar "$HOME"/.autodl/
    app-autodl-irssi start
    echo "AutoDL-irssi" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/bazarr)" ];
then
    echo "Backing up Bazarr..."
    app-bazarr stop
    tar -cvf "$HOME"/apps/bazarr.tar "$HOME"/.apps/bazarr/
    app-bazarr start
    echo "Bazarr" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/btsync)" ];
then
    echo "Backing up Resilio Sync..."
    app-btsync stop
    tar -cvf "$HOME"/apps/btsync.tar "$HOME"/.apps/btsync/
    app-btsync start
    echo "Resilio Sync" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/couchpotato)" ];
then
    echo "Backing up CouchPotato..."
    app-couchpotato stop
    tar -cvf "$HOME"/apps/couchpotato.tar "$HOME"/.apps/couchpotato/
    app-couchpotato start
    echo "CouchPotato" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/emby)" ];
then
    echo "Backing up Emby..."
    app-emby stop
    tar -cvf "$HOME"/apps/emby.tar "$HOME"/.apps/emby/
    app-emby start
    echo "Emby" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/jackett)" ];
then
    echo "Backing up Jackett..."
    app-jackett stop
    tar -cvf "$HOME"/apps/jackett.tar "$HOME"/.apps/jackett/
    app-jackett start
    echo "Jackett" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.config/jdownloader2)" ];
then
    echo "Backing up JDownloader2..."
    app-jdownloader2 stop
    tar -cvf "$HOME"/apps/jdownloader2.tar "$HOME"/.config/jdownloader2/
    app-jdownloader2 start
    echo "JDownloader2" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/jellyfin)" ];
then
    echo "Backing up Jellyfin..."
    app-jellyfin stop
    tar -cvf "$HOME"/apps/jellyfin.tar "$HOME"/.apps/jellyfin/
    app-jellyfin start
    echo "Jellyfin" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.config/lazylibrarian)" ];
then
    echo "Backing up LazyLibrarian..."
    app-lazylibrarian stop
    tar -cvf "$HOME"/apps/lazylibrarian.tar "$HOME"/.config/lazylibrarian/
    app-lazylibrarian start
    echo "LazyLibrarian" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.config/lidarr)" ];
then
    echo "Backing up Lidarr..."
    app-lidarr stop
    tar -cvf "$HOME"/apps/lidarr.tar "$HOME"/.config/lidarr/
    app-lidarr start
    echo "Lidarr" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/medusa)" ];
then
    echo "Backing up Medusa..."
    app-medusa stop
    tar -cvf "$HOME"/apps/medusa.tar "$HOME"/.apps/medusa/
    app-medusa start
    echo "Medusa" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/mylar)" ] && [ -n "$(ls -A "$HOME"/.config/mylar)" ];
then
    echo "Backing up Mylar..."
    app-mylar stop
    tar -cvf "$HOME"/apps/mylar.tar "$HOME"/.apps/mylar/ "$HOME"/.config/mylar/
    app-mylar start
    echo "Mylar" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.config/nzbget)" ];
then
    echo "Backing up nzbget..."
    app-nzbget stop
    tar -cvf "$HOME"/apps/nzbget.tar "$HOME"/.config/nzbget/
    app-nzbget start
    echo "NZBGet" >> "$HOME"/backup/backup.txt
elif [ -n "$(ls -A "$HOME"/.apps/nzbget)" ];
then
    echo "Backing up nzbget..."
    app-nzbget stop
    tar -cvf "$HOME"/apps/nzbget.tar "$HOME"/.apps/nzbget/
    app-nzbget start
    echo "NZBGet" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.config/nzbhydra2)" ];
then
    echo "Backing up NZBHydra2..."
    app-nzbhydra2 stop
    tar -cvf "$HOME"/apps/nzbhydra2.tar "$HOME"/.config/nzbhydra2/
    app-nzbhydra2 start
    echo "NZBHydra2" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.config/ombi)" ];
then
    echo "Backing up Ombi..."
    app-ombi stop
    tar -cvf "$HOME"/apps/ombi.tar "$HOME"/.config/ombi/
    app-ombi start
    echo "Ombi" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.config/plex)" ];
then
    echo "Backing up Plex..."
    app-plex stop
    tar -cvf "$HOME"/apps/plex.tar "$HOME"/.config/plex/
    app-plex start
    echo "Plex" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/radarr)" ];
then
    echo "Backing up Radarr..."
    app-radarr stop
    tar -cvf "$HOME"/apps/radarr.tar "$HOME"/.apps/radarr/
    app-radarr start
    echo "Radarr" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sabnzbd)" ];
then
    echo "Backing up SABnzbd..."
    app-sabnzbd stop
    tar -cvf "$HOME"/apps/sabnzbd.tar "$HOME"/.apps/sabnzbd/
    app-sabnzbd start
    echo "SABnzbd" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sickchill)" ];
then
    echo "Backing up SickChill..."
    app-sickchill stop
    tar -cvf "$HOME"/apps/sickchill.tar "$HOME"/.apps/sickchill/
    app-sickchill start
    echo "SickChill" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sonarr)" ];
then
    echo "Backing up Sonarr..."
    app-sonarr stop
    tar -cvf "$HOME"/apps/sonarr.tar "$HOME"/.apps/sonarr/
    app-sonarr start
    echo "Sonarr" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/syncthing)" ];
then
    echo "Backing up Syncthing..."
    app-syncthing stop
    tar -cvf "$HOME"/apps/syncthing.tar "$HOME"/.apps/syncthing/
    app-syncthing start
    echo "Syncthing" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.config/tautulli)" ];
then
    echo "Backing up Tautulli..."
    app-tautulli stop
    tar -cvf "$HOME"/apps/tautulli.tar "$HOME"/.config/tautulli/
    app-tautulli start
    echo "Tautulli" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/transmission)" ];
then
    echo "Backing up Transmission..."
    app-transmission stop
    tar -cvf "$HOME"/apps/transmission.tar "$HOME"/.apps/transmission/
    app-transmission start
    echo "Transmission" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/ubooquity)" ] && [ -n "$(ls -A "$HOME"/.config/ubooquity)" ];
then
    echo "Backing up Ubooquity..."
    app-ubooquity stop
    tar -cvf "$HOME"/apps/ubooquity.tar "$HOME"/.apps/ubooquity/ "$HOME"/.config/ubooquity/
    app-ubooquity start
    echo "Ubooquity" >> "$HOME"/backup/backup.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/ubooquity)" ];
then
    echo "Backing up ZNC..."
    app-znc stop
    tar -cvf "$HOME"/apps/znc.tar "$HOME"/.apps/znc/
    app-znc start
    echo "ZNC" >> "$HOME"/backup/backup.txt
fi

{
echo ""
echo "Please save this folder in a safe location or run the migration script on this slot."
echo ""
echo "If you run the migration script, please make sure you have installed the apps listed above on the new slot."
} >> "$HOME"/backup/backup.txt

clear
cat "$HOME"/backup/backup.txt
exit 