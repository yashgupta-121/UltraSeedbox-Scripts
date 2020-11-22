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
    mkdir -p "$HOME"/backup/Data

cd "$HOME" || exit

clear
echo "Do you want to start your applications after backing up?"
read -rp "Type yes or no: " input2

if [ "$input2" == no ];
then
    clear
    echo "Do you want to move your Torrent Data Files and media folder to the backup folder?"
    read -rp "Type yes or no: " input3
fi

if [ "$input3" == yes ];
then
if [ -n "$(ls -A "$HOME"/files/ 2>/dev/null)" ];
    then
        echo "Moving files..."
        mkdir -p "$HOME"/backup/Data/files/
        mv -fv "$HOME"/files/ "$HOME"/backup/Data/files/
        echo "$HOME/files/" >>  "$HOME"/restore-list.txt
    fi

    if [ -n "$(ls -A "$HOME"/Downloads/ 2>/dev/null)" ];
    then
        echo "Moving Downloads..."
        mkdir -p "$HOME"/backup/Data/Downloads/
        mv -fv "$HOME"/Downloads/ "$HOME"/backup/Data/Downloads/
        echo "$HOME/Downloads/" >>  "$HOME"/restore-list.txt
    fi
    
    if [ -n "$(ls -A "$HOME"/Downloads/ 2>/dev/null)" ];
    then
        echo "Moving Downloads..."
        mkdir -p "$HOME"/backup/Data/Downloads/
        mv -fv "$HOME"/Downloads/ "$HOME"/backup/Data/Downloads/
        echo "$HOME/Downloads/" >>  "$HOME"/restore-list.txt
    fi
fi

# Backup proper
clear
{
echo ""
echo "You have backed up the following apps:"
echo ""
} >> "$HOME"/backup/backup-list.txt

if [ -n "$(ls -A "$HOME"/.config/airsonic 2>/dev/null)" ] && [ -n "$(ls -A "$HOME"/.apps/airsonic 2>/dev/null)" ];
then
    echo "Backing up Airsonic..."
    app-airsonic stop
    tar -cvf "$HOME"/backup/apps/airsonic.tar .config/airsonic/ .apps/airsonic/
    if [ "$input2" = "yes" ]; then
        app-airsonic start
    fi
    echo "Airsonic" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.autodl 2>/dev/null)" ];
then
    echo "Backing up autodl..."
    app-autodl-irssi stop
    tar -cvf "$HOME"/backup/apps/autodl-irssi.tar .autodl/
    if [ "$input2" = "yes" ]; then
        app-autodl-irssi start
    fi
    echo "AutoDL-irssi" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/bazarr 2>/dev/null)" ];
then
    echo "Backing up Bazarr..."
    app-bazarr stop
    tar -cvf "$HOME"/backup/apps/bazarr.tar .apps/bazarr/
    if [ "$input2" = "yes" ]; then
        app-bazarr start
    fi
    echo "Bazarr" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/btsync 2>/dev/null)" ];
then
    echo "Backing up Resilio Sync..."
    app-btsync stop
    tar -cvf "$HOME"/backup/apps/btsync.tar .apps/btsync/
    if [ "$input2" = "yes" ]; then
        app-btsync start
    fi
    echo "Resilio Sync" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/couchpotato 2>/dev/null)" ];
then
    echo "Backing up CouchPotato..."
    app-couchpotato stop
    tar -cvf "$HOME"/backup/apps/couchpotato.tar .apps/couchpotato/
    if [ "$input2" = "yes" ]; then
        app-couchpotato start
    fi
    echo "CouchPotato" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/deluge 2>/dev/null)" ];
then
    echo "Backing up Deluge..."
    app-deluge stop
    tar -cvf "$HOME"/backup/apps/deluge.tar .config/deluge/
    if [ "$input2" = "yes" ]; then
        app-deluge start
    fi
    echo "Deluge" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/emby 2>/dev/null)" ];
then
    echo "Backing up Emby..."
    app-emby stop
    tar -cvf "$HOME"/backup/apps/emby.tar .apps/emby/
    if [ "$input2" = "yes" ]; then
        app-emby start
    fi
    echo "Emby" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/jackett 2>/dev/null)" ];
then
    echo "Backing up Jackett..."
    app-jackett stop
    tar -cvf "$HOME"/backup/apps/jackett.tar .apps/jackett/
    if [ "$input2" = "yes" ]; then
        app-jackett start
    fi
    echo "Jackett" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/jdownloader2 2>/dev/null)" ];
then
    echo "Backing up JDownloader2..."
    app-jdownloader2 stop
    tar -cvf "$HOME"/backup/apps/jdownloader2.tar .config/jdownloader2/
    if [ "$input2" = "yes" ]; then
        app-jdownloader2 start
    fi
    echo "JDownloader2" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/jellyfin 2>/dev/null)" ];
then
    echo "Backing up Jellyfin..."
    app-jellyfin stop
    tar -cvf "$HOME"/backup/apps/jellyfin.tar .apps/jellyfin/
    if [ "$input2" = "yes" ]; then
        app-jellyfin start
    fi
    echo "Jellyfin" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/lazylibrarian 2>/dev/null)" ];
then
    echo "Backing up LazyLibrarian..."
    app-lazylibrarian stop
    tar -cvf "$HOME"/backup/apps/lazylibrarian.tar .config/lazylibrarian/
    if [ "$input2" = "yes" ]; then
        app-lazylibrarian start
    fi
    echo "LazyLibrarian" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/lidarr 2>/dev/null)" ];
then
    echo "Backing up Lidarr..."
    app-lidarr stop
    tar -cvf "$HOME"/backup/apps/lidarr.tar .config/lidarr/
    if [ "$input2" = "yes" ]; then
        app-lidarr start
    fi
    echo "Lidarr" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/medusa 2>/dev/null)" ];
then
    echo "Backing up Medusa..."
    app-medusa stop
    tar -cvf "$HOME"/backup/apps/medusa.tar .apps/medusa/
    if [ "$input2" = "yes" ]; then
        app-medusa start
    fi
    echo "Medusa" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/mylar 2>/dev/null)" ] && [ -n "$(ls -A "$HOME"/.config/mylar 2>/dev/null)" ];
then
    echo "Backing up Mylar..."
    app-mylar stop
    tar -cvf "$HOME"/backup/apps/mylar.tar .apps/mylar/ .config/mylar/
    if [ "$input2" = "yes" ]; then
        app-mylar start
    fi
    echo "Mylar" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/nzbget 2>/dev/null)" ];
then
    echo "Backing up nzbget..."
    app-nzbget stop
    tar -cvf "$HOME"/backup/apps/nzbget.tar .config/nzbget/
    if [ "$input2" = "yes" ]; then
        app-nzbget start
    fi
    echo "NZBGet" >>  "$HOME"/backup/backup-list.txt
elif [ -n "$(ls -A "$HOME"/.apps/nzbget 2>/dev/null)" ];
then
    echo "Backing up nzbget..."
    app-nzbget stop
    tar -cvf "$HOME"/backup/apps/nzbget.tar .apps/nzbget/
    if [ "$input2" = "yes" ]; then
        app-nzbget start
    fi
    echo "NZBGet" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/nzbhydra2 2>/dev/null)" ];
then
    echo "Backing up NZBHydra2..."
    app-nzbhydra2 stop
    tar -cvf "$HOME"/backup/apps/nzbhydra2.tar .config/nzbhydra2/
    if [ "$input2" = "yes" ]; then
        app-nzbhydra2 start
    fi
    echo "NZBHydra2" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/ombi 2>/dev/null)" ];
then
    echo "Backing up Ombi..."
    app-ombi stop
    tar -cvf "$HOME"/backup/apps/ombi.tar .config/ombi/
    if [ "$input2" = "yes" ]; then
        app-ombi start
    fi
    echo "Ombi" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/plex 2>/dev/null)" ];
then
    echo "Backing up Plex..."
    app-plex stop
    tar -cvf "$HOME"/backup/apps/plex.tar .config/plex/
    if [ "$input2" = "yes" ]; then
        app-plex start
    fi
    echo "Plex" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/radarr 2>/dev/null)" ];
then
    echo "Backing up Radarr..."
    app-radarr stop
    tar -cvf "$HOME"/backup/apps/radarr.tar .apps/radarr/
    if [ "$input2" = "yes" ]; then
        app-radarr start
    fi
    echo "Radarr" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/rtorrent 2>/dev/null)" ];
then
    echo "Backing up rTorrent & ruTorrent..."
    app-rtorrent stop
    tar -cvf "$HOME"/backup/apps/rtorrent.rar .config/rtorrent/
    if [ "$input2" = "yes" ]; then
        app-rtorrent start
    fi
    echo "rTorrent" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sabnzbd 2>/dev/null)" ];
then
    echo "Backing up SABnzbd..."
    app-sabnzbd stop
    tar -cvf "$HOME"/backup/apps/sabnzbd.tar .apps/sabnzbd/
    if [ "$input2" = "yes" ]; then
        app-sabnzbd start
    fi
    echo "SABnzbd" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sickchill 2>/dev/null)" ];
then
    echo "Backing up SickChill..."
    app-sickchill stop
    tar -cvf "$HOME"/backup/apps/sickchill.tar .apps/sickchill/
    if [ "$input2" = "yes" ]; then
        app-sickchill start
    fi
    echo "SickChill" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/sonarr 2>/dev/null)" ];
then
    echo "Backing up Sonarr..."
    app-sonarr stop
    tar -cvf "$HOME"/backup/apps/sonarr.tar .apps/sonarr/
    if [ "$input2" = "yes" ]; then
        app-sonarr start
    fi
    echo "Sonarr" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/syncthing 2>/dev/null)" ];
then
    echo "Backing up Syncthing..."
    app-syncthing stop
    tar -cvf "$HOME"/backup/apps/syncthing.tar .apps/syncthing/
    if [ "$input2" = "yes" ]; then
        app-syncthing start
    fi
    echo "Syncthing" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.config/tautulli 2>/dev/null)" ];
then
    echo "Backing up Tautulli..."
    app-tautulli stop
    tar -cvf "$HOME"/backup/apps/tautulli.tar .config/tautulli/
    if [ "$input2" = "yes" ]; then
        app-tautulli start
    fi
    echo "Tautulli" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/transmission 2>/dev/null)" ];
then
    echo "Backing up Transmission..."
    app-transmission stop
    tar -cvf "$HOME"/backup/apps/transmission.tar .apps/transmission/
    if [ "$input2" = "yes" ]; then
        app-transmission start
    fi
    echo "Transmission" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/ubooquity 2>/dev/null)" ] && [ -n "$(ls -A "$HOME"/.config/ubooquity 2>/dev/null)" ];
then
    echo "Backing up Ubooquity..."
    app-ubooquity stop
    tar -cvf "$HOME"/backup/apps/ubooquity.tar .apps/ubooquity/ .config/ubooquity/
    if [ "$input2" = "yes" ]; then
        app-ubooquity start
    fi
    echo "Ubooquity" >>  "$HOME"/backup/backup-list.txt
fi

if [ -n "$(ls -A "$HOME"/.apps/ubooquity 2>/dev/null)" ];
then
    echo "Backing up ZNC..."
    app-znc stop
    tar -cvf "$HOME"/backup/apps/znc.tar .apps/znc/
    if [ "$input2" = "yes" ]; then
        app-znc start
    fi
    echo "ZNC" >>  "$HOME"/backup/backup-list.txt
fi

{
echo ""
echo "Please save this folder in a safe location or run the migration script on this slot."
echo ""
echo "If you run the migration script, please make sure you have installed the apps listed above on your new slot first and you stopped all of your running apps on your old slot."
echo "Please take note that the your old slot's HOME NUMBER AND USERNAME is $PWD"
echo ""
echo "Enter this when asked during the restore script."
} >> "$HOME"/backup/backup-list.txt

clear
cat "$HOME"/backup/backup-list.txt
exit