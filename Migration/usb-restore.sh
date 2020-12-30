#!/bin/bash

# USB Slot Restore Tool by Xan#7777

# Unofficial Script warning
clear
echo "This is the USB Restore Tool!"
echo ""
printf "\033[0;31mDisclaimer: This script is unofficial and USB staff will not support any issues with it\033[0m\n"
read -rp "Type confirm if you wish to continue: " input
if [ ! "$input" = "confirm" ]
then
    exit
fi

# Checking if transfer folder exists
clear
echo "Checking for the transfer folder..."
if [ -z "$(ls -A "$HOME"/transfer 2>/dev/null)" ];
then
    echo "Transfer folder found"
else
    clear
    echo "Transfer folder not found."
    echo "Have you run the migration script? Script will exit"
    exit 0
fi

echo "Creating necessary folders..."
    mkdir -p "$HOME"/default-backup
    mkdir -p "$HOME"/default-backup/config
    mkdir -p "$HOME"/default-backup/apps
    cd "$HOME" || exit

# Updating webserver to latest
echo "Updating webserver..."
    app-nginx uninstall
    app-nginx install

# Restore warning
clear
echo "Restore is about to start."
echo ""
echo "Please do not close this session while it's running"
read -rp "Type confirm if you wish to continue: " input
if [ ! "$input" = "confirm" ]
then
    exit
fi

# Restore Torrent Data/Extras

sleep 10

echo "You have moved the following folders:" > "$HOME"/restore-list.txt
echo "" >> "$HOME"/restore-list.txt

if [ -n "$(ls -A "$HOME"/backup/files/ 2>/dev/null)" ];
then
    echo "Moving files..."
    mkdir -p "$HOME"/files/
    mv -fv "$HOME"/backup/Data/files/ "$HOME"/files/
    echo "$HOME/files/" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/backup/Downloads/ 2>/dev/null)" ];
then
    echo "Moving Downloads..."
    mkdir -p "$HOME"/Downloads/
    mv -fv "$HOME"/backup/Downloads/ "$HOME"/Downloads/
    echo "$HOME/Downloads/" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/backup/Extras/ 2>/dev/null)" ];
then
    echo "Moving Extras..."
    mkdir -p "$HOME"/Extras/
    mv -fv "$HOME"/backup/Extras/ "$HOME"/Extras/
    echo "$HOME/Extras/" >>  "$HOME"/restore-list.txt
fi

# restore apps
{
echo ""
echo "You have restored the following apps:"
echo ""
} >> "$HOME"/restore-list.txt

if [ -z "$(ls -A "$HOME"/.config/airsonic 2>/dev/null)" ] && [ -z "$(ls -A "$HOME"/.apps/airsonic 2>/dev/null)" ];
then
    echo "Restoring Airsonic..."
    app-airsonic stop
    mv -fv "$HOME"/.config/airsonic/ "$HOME"/default-backup/config/airsonic/
    mv -fv "$HOME"/.apps/airsonic/ "$HOME"/default-backup/apps/airsonic/
    tar -xvf "$HOME"/backup/apps/airsonic.tar
    app-airsonic start
    echo "Airsonic" >> "$HOME"/restore-list.txt
fi

if [ -z "$(ls -A "$HOME"/.autodl 2>/dev/null)" ];
then
    echo "Restoring autodl..."
    app-autodl-irssi stop
    mv -fv "$HOME"/.autodl/ "$HOME"/default-backup/.autodl
    tar -xvf "$HOME"/backup/apps/autodl-irssi.tar
    adl2nd=$(< "$HOME"/default-backup/.autodl/autodl.cfg sed -n '2p')
    adl3rd=$(< "$HOME"/default-backup/.autodl/autodl.cfg sed -n '3p')
    sed -i -E "s|gui-server-port = .*|$adl2nd|g" "$HOME"/.autodl/autodl.cfg
    sed -i -E "s|gui-server-password = .*|$adl3rd|g" "$HOME"/.autodl/autodl.cfg
    app-autodl-irssi start
    echo "AutoDL-irssi" >> "$HOME"/restore-list.txt
fi

if [ -z "$(ls -A "$HOME"/.apps/bazarr 2>/dev/null)" ];
then
    echo "Restoring Bazarr..."
    app-bazarr stop
    mv -fv "$HOME"/.apps/bazarr/ "$HOME"/default-backup/apps/bazarr/
    tar -xvf "$HOME"/backup/apps/bazarr.tar
    app-bazarr start
    echo "Bazarr" >>  "$HOME"/restore-list.txt
fi

if [ -z "$(ls -A "$HOME"/.apps/btsync 2>/dev/null)" ];
then
    echo "Restoring Resilio Sync..."
    app-btsync stop
    mv -fv "$HOME"/.apps/btsync/ "$HOME"/default-backup/apps/btsync/
    tar -xvf "$HOME"/backup/apps/btsync.tar
    app-btsync start
    echo "Resilio Sync" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/couchpotato 2>/dev/null)" ];
then
    echo "Restoring CouchPotato..."
    app-couchpotato stop
    mv -fv "$HOME"/.apps/couchpotato/ "$HOME"/default-backup/apps/couchpotato/
    tar -xvf "$HOME"/backup/apps/couchpotato.tar
    app-couchpotato start
    echo "CouchPotato" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/emby 2>/dev/null)" ];
then
    echo "Restoring Emby..."
    app-emby stop
    mv -fv "$HOME"/.apps/emby/ "$HOME"/default-backup/apps/emby/
    tar -xvf "$HOME"/backup/apps/emby.tar
    app-emby start
    echo "Emby" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/jackett 2>/dev/null)" ];
then
    echo "Restoring Jackett..."
    app-jackett stop
    mv -fv "$HOME"/.apps/jackett/ "$HOME"/default-backup/apps/jackett/
    tar -xvf "$HOME"/backup/apps/jackett.tar
    app-jackett start
    echo "Jackett. Please set a new password for Jackett on your UCP." >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/jdownloader2 2>/dev/null)" ];
then
    echo "Restoring JDownloader2..."
    app-jdownloader2 stop
    mv -fv "$HOME"/.config/jdownloader2/ "$HOME"/default-backup/config/jdownloader2/
    tar -xvf "$HOME"/backup/apps/jdownloader2.tar
    app-jdownloader2 start
    echo "JDownloader2" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/jellyfin 2>/dev/null)" ];
then
    echo "Restoring Jellyfin..."
    app-jellyfin stop
    mv -fv "$HOME"/.apps/jellyfin/ "$HOME"/default-backup/apps/jellyfin/
    tar -xvf "$HOME"/backup/apps/jellyfin.tar
    app-jellyfin start
    echo "Jellyfin" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/lazylibrarian 2>/dev/null)" ];
then
    echo "Restoring LazyLibrarian..."
    app-lazylibrarian stop
    mv -fv "$HOME"/.config/lazylibrarian/ "$HOME"/default-backup/config/lazylibrarian/
    tar -xvf "$HOME"/backup/apps/lazylibrarian.tar
    app-lazylibrarian start
    echo "LazyLibrarian" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/lidarr 2>/dev/null)" ];
then
    echo "Restoring Lidarr..."
    app-lidarr stop
    mv -fv "$HOME"/.config/lidarr/ "$HOME"/default-backup/config/lidarr/
    tar -xvf "$HOME"/backup/apps/lidarr.tar
    app-lidarr start
    echo "Lidarr" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/medusa 2>/dev/null)" ];
then
    echo "Restoring Medusa..."
    app-medusa stop
    mv -fv "$HOME"/.apps/medusa/ "$HOME"/default-backup/apps/medusa/
    tar -xvf "$HOME"/backup/apps/medusa.tar
    app-medusa start
    echo "Medusa" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/mylar 2>/dev/null)" ] && [ -n "$(ls -A "$HOME"/.config/mylar 2>/dev/null)" ];
then
    echo "Restoring Mylar..."
    app-mylar stop
    mv -fv "$HOME"/.apps/mylar/ "$HOME"/default-backup/apps/mylar/
    mv -fv "$HOME"/.config/mylar "$HOME"/default-backup/config/mylar/
    tar -xvf "$HOME"/backup/apps/mylar.tar
    app-mylar start
    echo "Mylar" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/nzbget 2>/dev/null)" ];
then
    echo "Restoring nzbget..."
    app-nzbget stop
    mv -fv "$HOME"/.config/nzbget/ "$HOME"/default-backup/config/nzbget/
    tar -xvf "$HOME"/backup/apps/nzbget
    app-nzbget start
    echo "NZBGet" >>  "$HOME"/restore-list.txt
elif [ -n "$(ls -A "$HOME"/.apps/nzbget 2>/dev/null)" ];
then
    echo "Restoring nzbget..."
    app-nzbget stop
    mv -fv "$HOME"/.apps/nzbget "$HOME"/default-backup/apps/nzbget/
    tar -xvf "$HOME"/backup/apps/nzbget
    app-nzbget start
    echo "NZBGet" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/nzbhydra2 2>/dev/null)" ];
then
    echo "Restoring NZBHydra2..."
    app-nzbhydra2 stop
    mv -fv "$HOME"/.config/nzbhydra2/ "$HOME"/default-backup/config/nzbhydra2/
    tar -xvf "$HOME"/backup/apps/nzbhydra2.tar
    app-nzbhydra2 start
    echo "NZBHydra2" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/ombi 2>/dev/null)" ];
then
    echo "Restoring Ombi..."
    app-ombi stop
    mv -fv "$HOME"/.config/ombi/ "$HOME"/default-backup/config/ombi/
    tar -xvf "$HOME"/backup/apps/ombi.tar
    app-ombi start
    echo "Ombi" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/plex 2>/dev/null)" ];
then
    echo "Restoring Plex..."
    app-plex stop
    mv -fv "$HOME"/.config/plex/ "$HOME"/default-backup/config/plex/
    tar -xvf "$HOME"/backup/apps/plex.tar
    app-plex start
    echo "Plex" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/radarr 2>/dev/null)" ];
then
    echo "Restoring Radarr..."
    app-radarr stop
    mv -fv "$HOME"/.apps/radarr/ "$HOME"/default-backup/apps/radarr/
    tar -xvf "$HOME"/backup/apps/radarr.tar
    app-radarr start
    echo "Radarr" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sabnzbd 2>/dev/null)" ];
then
    echo "Restoring SABnzbd..."
    app-sabnzbd stop
    mv -fv "$HOME"/.apps/sabnzbd/ "$HOME"/default-backup/apps/sabnzbd/
    tar -xvf "$HOME"/backup/apps/sabnzbd.tar
    app-sabnzbd start
    echo "SABnzbd. Please set a new password for SABnzbd on your UCP." >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sickchill 2>/dev/null)" ];
then
    echo "Restoring SickChill..."
    app-sickchill stop
    mv -fv "$HOME"/.apps/sickchill/ "$HOME"/default-backup/apps/sickchill/
    tar -cvf "$HOME"/backup/apps/sickchill.tar
    app-sickchill start
    echo "SickChill" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sonarr 2>/dev/null)" ];
then
    echo "Restoring Sonarr..."
    app-sonarr stop
    mv -fv "$HOME"/.apps/sonarr/ "$HOME"/default-backup/apps/sonarr/
    tar -cvf "$HOME"/backup/apps/sonarr.tar
    app-sonarr start
    echo "Sonarr. Please set a new password for Sonarr on your UCP." >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/syncthing 2>/dev/null)" ];
then
    echo "Restoring Syncthing..."
    app-syncthing stop
    mv -fv "$HOME"/.apps/syncthing/ "$HOME"/default-backup/apps/syncthing/
    tar -cvf "$HOME"/backup/apps/syncthing.tar
    app-syncthing start
    echo "Syncthing" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/tautulli 2>/dev/null)" ];
then
    echo "Restoring Tautulli..."
    app-tautulli stop
    mv -fv "$HOME"/.config/tautulli/ "$HOME"/default-backup/config/syncthing/
    tar -cvf "$HOME"/backup/apps/tautulli.tar
    app-tautulli start
    echo "Tautulli" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/ubooquity 2>/dev/null)" ] && [ -n "$(ls -A "$HOME"/.config/ubooquity 2>/dev/null)" ];
then
    echo "Restoring Ubooquity..."
    app-ubooquity stop
    tar -cvf "$HOME"/backup/apps/ubooquity .apps/ubooquity/ .config/ubooquity/
    app-ubooquity start
    echo "Ubooquity" >>  "$HOME"/restore-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/znc 2>/dev/null)" ];
then
    echo "Restoring ZNC..."
    app-znc stop
    tar -cvf "$HOME"/backup/apps/znc .apps/znc/
    app-znc start
    echo "ZNC" >>  "$HOME"/restore-list.txt
fi

{
echo ""
echo "Please save this folder in a safe location or run the migration script on this slot."
echo ""
echo "If you run the migration script, please make sure you have installed the apps listed above on the new slot first."
} >> "$HOME"/restore-list.txt

clear
cat "$HOME"/restore-list.txt
exit
