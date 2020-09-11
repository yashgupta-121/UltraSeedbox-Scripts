#!/bin/bash

# Rclone VFS/MergerFS Installer/Updater Script by Xan#7777

clear

printf "\033[0;31mDisclaimer: This installer is unofficial and USB staff will not support any issues with it\033[0m\n"
read -p "Type confirm if you wish to continue: " input
if [ ! "$input" = "confirm" ]
then
    exit 0
fi

clear

# Variables
quota=$(bc -l <<< "$(quota | grep "/" | awk {'print $3'})*1000*.02")
ze=$(numfmt --to=iec-i "$quota" | cut -b -3)

echo "Creating necessary folders..."
    mkdir -p "$HOME"/scripts
    mkdir -p "$HOME"/.config/systemd/user
    mkdir -p "$HOME"/.rclone-tmp
    mkdir -p "$HOME"/.mergerfs-tmp
    mkdir -p "$HOME"/.vfs-cache

echo "Disabling service files..."
    systemctl --user disable --now mergerfs.service
    systemctl --user disable --now rclone-vfs.service
    systemctl --user disable --now rclone-normal.service
    systemctl --user disable --now rclone-uploader.service
    systemctl --user disable --now rclone-uploader.timer

echo "Killing all rclone/mergerfs instances..."
    killall rclone
    killall mergerfs

echo "Removing service files and old binaries for upgrade..."
    rm "$HOME"/.config/systemd/user/rclone*
    rm "$HOME"/.config/systemd/user/mergerfs*
    rm "$HOME"/bin/rclone*
    rm "$HOME"/bin/mergerfs*
    rm "$HOME"/scripts/rclone*
    rm -rfv "$HOME"/.rclone-tmp/*
    rm -rfv "$HOME"/.mergerfs-tmp/*

echo "Setting XDG_RUNTIME_DIR"
    export XDG_RUNTIME_DIR=/run/user/"$UID"

clear

echo "Binary installation"
echo ""
echo "Installing rclone..."
    sleep 2
    wget https://downloads.rclone.org/rclone-current-linux-amd64.zip -O "$HOME"/.rclone-tmp/rclone.zip
    unzip rclone.zip
    cp "$HOME"/.rclone-tmp/rclone-v*/rclone "$HOME"/bin
    if [[ $("$HOME"/bin/rclone version) ]]; then
        echo "rclone installed correctly!"
        sleep 3
    else
        clear
        echo "rclone installation failed."
        echo "Please check if rclone binary is in ~/bin."
        echo "Script will now exit."
        exit 1
    fi
echo ""
echo ""
echo "Installing mergerfs..."
    sleep 2
    wget https://github.com/trapexit/mergerfs/releases/download/2.30.0/mergerfs_2.30.0.debian-stretch_amd64.deb -O "$HOME"/.mergerfs-tmp/mergerfs.deb
    dpkg -x "$HOME"/.mergerfs-tmp/mergerfs.deb "$HOME"/.mergerfs-tmp
    cp "$HOME"/.mergerfs-tmp/usr/bin/* "$HOME"/bin
    if [[ $("$HOME"/bin/mergerfs -V) ]]; then
        echo "mergerfs installed correctly!"
        sleep 3
    else
        clear
        echo "mergerfs installation failed."
        echo "Please check if mergerfs binary is in ~/bin."
        echo "Script will now exit."
        exit 2
    fi

clear

# rclone config check
echo "rclone config setup"
echo ""
echo "Have you configured your rclone remote?"
while true; do
    read -p "Type yes or no: " rconfig
    case "$rconfig" in
        yes)
            echo ""
            echo "Name of remote? Type below and press Enter."
            echo "Make sure it's the correct remote name or setup will fail."
            read -r remotename
            sleep 2
            if grep -Pzoq "\[$remotename\]\ntype = drive" "$HOME"/.config/rclone/rclone.conf; then
                echo ""
                echo "Your remote name is $remotename."
                echo "This will append to your rclone mount service files."
                sleep 2
                break
            else
                echo ""
                echo "Remote not found."
                echo ""
                echo "Please check your rclone remote name and run the installer again."
                echo "For more information, you may refer to the following sites."
                echo "==================================================================================="
                echo "https://docs.usbx.me/books/rclone/page/installation-configuration-usage-of-rclone"
                echo "https://docs.usbx.me/books/rclone/page/configuring-oauth-for-google-drive"
                echo "https://rclone.org/commands/rclone_config/"
                echo "==================================================================================="
                echo "Take note that this installer only supports Google Drive."
                echo "Should you use any other remote, please refer to the manual installation of rclone-mergerfs guide."
                echo "installer will now exit."
                exit 3
            fi
            ;;
        no)
            clear
            echo "Please set your rclone config first. Refer to the following sites."
            echo "==================================================================================="
            echo "https://docs.usbx.me/books/rclone/page/installation-configuration-usage-of-rclone"
            echo "https://docs.usbx.me/books/rclone/page/configuring-oauth-for-google-drive"
            echo "https://rclone.org/commands/rclone_config/"
            echo "==================================================================================="
            echo "Take note that this installer only supports Google Drive."
            echo "Should you use any other remote, please refer to the manual installation of rclone-mergerfs guide."
            echo "installer will now exit."
            exit 4
            ;;
        *) echo "Unknown response. Try again..." ;;
    esac
done

clear

# VFS Folders setup

echo "VFS folders setup"
echo ""
echo "Want to customize the name of the rclone folders or use the default folders?"
while true; do
read -p "Type custom or default: " folconfig
    case $folconfig in
        custom)
            read -p "Type the name of the folder where you'll put Local and Mount folders in: " stufffolder
            read -p "Type the name of the Local folder: " localfolder
            read -p "Type the name of the Mount folder: " mountfolder
            read -p "Type the name of the MergerFS folder: " mergerfsfolder
            mkdir -p "$HOME"/"$stufffolder"
            mkdir -p "$HOME"/"$stufffolder"/"$localfolder"
            mkdir -p "$HOME"/"$stufffolder"/"$mountfolder"
            mkdir -p "$HOME"/"$mergerfsfolder"
            break
            ;;
        default)
            mkdir -p "$HOME"/Stuff
            mkdir -p "$HOME"/Stuff/Local
            mkdir -p "$HOME"/Stuff/Mount
            mkdir -p "$HOME"/MergerFS
            break
            ;;
        *) echo "Unknown response. Try again..." ;;
    esac
done

# Check if folders are all empty


# Service file install
echo "Service file installation"
echo ""
echo "Done. Downloading service files..."
    sleep 2
    wget https://raw.githubusercontent.com/ultraseedbox/UltraSeedbox-Scripts/rclone-installer/MergerFS-Rclone/Service%20Files/rclone-vfs.service -O "$HOME"/.config/systemd/user/rclone-vfs.service
    wget https://raw.githubusercontent.com/ultraseedbox/UltraSeedbox-Scripts/rclone-installer/MergerFS-Rclone/Service%20Files/mergerfs.service -O "$HOME"/.config/systemd/user/mergerfs.service
    sed -i "s|rcloneremote:|$remotename:|g" "$HOME"/.config/systemd/user/rclone-vfs.service
    sed -i "s|iiiii|$ze|g" "$HOME"/.config/systemd/user/rclone-vfs.service
    if [ "$folconfig" = "custom" ]
    then
        sed -i "s|/homexx/yyyyy/Stuff/Mount|$HOME/$stufffolder/$mountfolder|g" "$HOME"/.config/systemd/user/rclone-vfs.service
        sed -i "s|/homexx/yyyyy/Stuff/Mount|$HOME/$stufffolder/$mountfolder|g" "$HOME"/.config/systemd/user/mergerfs.service
        sed -i "s|/homexx/yyyyy/Stuff/Local|$HOME/$stufffolder/$localfolder|g" "$HOME"/.config/systemd/user/mergerfs.service
        sed -i "s|/homexx/yyyyy/MergerFS|$HOME/$mergerfsfolder|g" "$HOME"/.config/systemd/user/mergerfs.service
    fi
    sed -i "s|/homexx/yyyyy|$HOME|g" "$HOME"/.config/systemd/user/mergerfs.service
    sed -i "s|/homexx/yyyyy|$HOME|g" "$HOME"/.config/systemd/user/rclone-vfs.service

clear

echo "Adding Aliases..."
    sleep 2
    if [ ! -f "$HOME"/.bash_aliases ]; then
        echo "Creating bash_aliases file and adding vfs aliases..."
        touch "$HOME"/.bash_aliases
        echo "alias vfs-start='systemctl --user start rclone-vfs.service && systemctl --user start mergerfs.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-stop='systemctl --user stop mergerfs.service && systemctl --user stop rclone-vfs.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-restart='systemctl --user stop mergerfs.service && systemctl --user stop rclone-vfs.service && sleep 3 && systemctl --user start rclone-vfs.service && systemctl --user start mergerfs.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-upgrade='wget https://raw.githubusercontent.com/ultraseedbox/UltraSeedbox-Scripts/rclone-installer/MergerFS-Rclone/Installer%20Scripts/rclone-mergerfs-installer.sh && chmod +x rclone-mergerfs-installer.sh && ./rclone-mergerfs-installer.sh" >> "$HOME"/.bash_aliases
        echo "alias vfs-uploader-start='systemctl --user start rclone-uploader.service && systemctl --user start rclone-uploader.timer'" >> "$HOME"/.bash_aliases
        echo "alias vfs-uploader-stop='systemctl --user stop rclone-uploader.timer && systemctl --user stop rclone-uploader.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-uploader-disable='systemctl --user disable --now rclone-uploader.timer && systemctl --user disable --now rclone-uploader.service'" >> "$HOME"/.bash_aliases
    elif grep -q -E "alias vfs-.*" "$HOME"/.bash_aliases; then
        echo "VFS aliases found. Replacing with new credentials..."
        sed -i '/^alias vfs-/d' "$HOME"/.bash_aliases
        echo "alias vfs-start='systemctl --user start rclone-vfs.service && systemctl --user start mergerfs.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-stop='systemctl --user stop mergerfs.service && systemctl --user stop rclone-vfs.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-restart='systemctl --user stop mergerfs.service && systemctl --user stop rclone-vfs.service && sleep 3 && systemctl --user start rclone-vfs.service && systemctl --user start mergerfs.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-upgrade='wget https://raw.githubusercontent.com/ultraseedbox/UltraSeedbox-Scripts/rclone-installer/MergerFS-Rclone/Installer%20Scripts/rclone-mergerfs-installer.sh && chmod +x rclone-mergerfs-installer.sh && ./rclone-mergerfs-installer.sh" >> "$HOME"/.bash_aliases
        echo "alias vfs-uploader-start='systemctl --user start rclone-uploader.service && systemctl --user start rclone-uploader.timer'" >> "$HOME"/.bash_aliases
        echo "alias vfs-uploader-stop='systemctl --user stop rclone-uploader.timer && systemctl --user stop rclone-uploader.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-uploader-disable='systemctl --user disable --now rclone-uploader.timer && systemctl --user disable --now rclone-uploader.service'" >> "$HOME"/.bash_aliases
    else
        echo "alias vfs-start='systemctl --user start rclone-vfs.service && systemctl --user start mergerfs.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-stop='systemctl --user stop mergerfs.service && systemctl --user stop rclone-vfs.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-restart='systemctl --user stop mergerfs.service && systemctl --user stop rclone-vfs.service && sleep 3 && systemctl --user start rclone-vfs.service && systemctl --user start mergerfs.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-upgrade='wget https://raw.githubusercontent.com/ultraseedbox/UltraSeedbox-Scripts/rclone-installer/MergerFS-Rclone/Installer%20Scripts/rclone-mergerfs-installer.sh && chmod +x rclone-mergerfs-installer.sh && ./rclone-mergerfs-installer.sh" >> "$HOME"/.bash_aliases
        echo "alias vfs-uploader-start='systemctl --user start rclone-uploader.service && systemctl --user start rclone-uploader.timer'" >> "$HOME"/.bash_aliases
        echo "alias vfs-uploader-stop='systemctl --user stop rclone-uploader.timer && systemctl --user stop rclone-uploader.service'" >> "$HOME"/.bash_aliases
        echo "alias vfs-uploader-disable='systemctl --user disable --now rclone-uploader.timer && systemctl --user disable --now rclone-uploader.service'" >> "$HOME"/.bash_aliases
    fi

clear

# Starting systemd mounts
echo "Starting services..."
    sleep 3
    systemctl --user daemon-reload
    systemctl --user enable --now rclone-vfs.service
    systemctl --user enable --now mergerfs.service

# Setup Check
echo "Checking if rclone/mergerfs mounts are working..."
    if [ -z "$(ls -A "$HOME"/Stuff/Local)" ]; then
        echo "Local Folder Empty. Continuing..."
        sleep 5
    else
        echo "Installer detected that Local folder is not empty. Maybe you have some files here that's not yet been moved or you're using hardlinking."
        echo "Setup will continue..."
        sleep 5
    fi
    if [ -z "$(ls -A "$HOME"/Stuff/Mount)" ]; then
        echo "Mount Folder is empty. Checking your rclone config..."
        sleep 3
        if rclone lsd "$remotename": | grep "Failed"; then
            echo "Mount successful but it's empty. Setup will continue..."
        else
            echo "Rclone configuration error."
            echo "Run this installer again to set it up."
            exit
        fi
    else
        echo "Mount Folder is mounted successfully. Continuing..."
        sleep 5
    fi
    cd "$HOME"/MergerFS || exit
    touch test
    echo "MergerFS Test 1 Started..."
    if [ -f "$HOME"/MergerFS/test ] && [ -f "$HOME"/Stuff/Local/test ] && [ ! -f "$HOME"/Stuff/Mount/test ]; then
        echo "MergerFS Test 1 ended successfully."
        echo "Continuing setup..."
        sleep 5
    else
        echo "MergerFS Test 1 is not successful."
        echo "Run the installer again."
        exit
    fi

clear

    echo "MergerFS Test 2 Starting..."
    rclone move "$HOME"/Stuff/Local/test "$remotename": -vvv
    echo "Waiting for 60 seconds..."
    sleep 60
        if [ -f "$HOME"/MergerFS/test ] && [ ! -f "$HOME"/Stuff/Local/test ] && [ -f "$HOME"/Stuff/Mount/test ]; then
        echo "MergerFS Test 2 ended successfully."
        echo "Continuing setup..."
        sleep 5
    else
        echo "MergerFS Test 2 not successful."
        echo "This might be due to the remote/system not refreshing accordingly and you can probably skip this and check later. Skip?"
        read -p "Type yes or no: " choice
        if [ "$choice" = "yes" ]
        then
            echo "Got it. Skipping..."
        elif [ "$choice" = "no" ]
        then
            echo "Gotcha. installer will exit."
            exit
        fi
    fi

# Media Center Tuneup (Some simple seds to optimize Plex for media cloud mount)
# Will add more later

clear
echo "Are you using Plex?"
read -p "Type yes or no: " input1
if [ "$input1" = "yes" ]
then
    echo "Applying some tweaks to Plex...."
    sed -i -E 's/GenerateIntroMarkerBehavior="(scheduled|asap)"/GenerateIntroMarkerBehavior="never"/g' "$HOME"/.config/plex/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
    sed -i -E 's/GenerateChapterThumbBehavior="(scheduled|asap)"/GenerateChapterThumbBehavior="never"/g' "$HOME"/.config/plex/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
    sed -i -E 's/LoudnessAnalysisBehavior="(scheduled|asap)"/LoudnessAnalysisBehavior="never"/g' "$HOME"/.config/plex/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
    sed -i 's|ButlerTaskDeepMediaAnalysis="1"|ButlerTaskDeepMediaAnalysis="0"|g' "$HOME"/.config/plex/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
    sed -i 's|DisableTLSv1_0="0"|DisableTLSv1_0="1"|g' "$HOME"/.config/plex/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
    sed -i 's|DlnaReportTimeline="1"|DlnaReportTimeline="0"|g' "$HOME"/.config/plex/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
    sed -i 's|DlnaEnabled="1"|DlnaEnabled="0"|g' "$HOME"/.config/plex/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
    sed -i 's|GdmEnabled="1"|GdmEnabled="0"|g' "$HOME"/.config/plex/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
    app-plex restart
    sleep 10
elif [ "$input1" = "no" ]
then
    echo "Skipping..."
    sleep 2
fi

echo "Cleaning up..."
    sleep 2
    rclone delete "$remotename":test
    rm -rfv "$HOME"/.rclone-tmp
    rm -rfv "$HOME"/.mergerfs-tmp

# Uploader Installer

clear

echo "rclone Uploader setup"
echo ""
echo "Here, you can choose between the systemd uploader, the normal rclone upload script or the rclone script with discord webhook."
echo "We recommend the systemd uploader."
while true; do
read -p "Type in 'systemd', 'normal' or 'discord': " uploadconfig
case $uploadconfig in
    systemd)
        wget https://raw.githubusercontent.com/ultraseedbox/UltraSeedbox-Scripts/rclone-installer/MergerFS-Rclone/Upload%20Scripts/rclone-uploader.service -O "$HOME"/.config/systemd/user/rclone-uploader.service
        wget https://raw.githubusercontent.com/ultraseedbox/UltraSeedbox-Scripts/rclone-installer/MergerFS-Rclone/Upload%20Scripts/rclone-uploader.timer -O "$HOME"/.config/systemd/user/rclone-uploader.timer
        if [ "$folconfig" = "custom" ]
        then
            sed -i "s|/homexx/yyyyy/Stuff/Local/|$HOME/$stufffolder/$localfolder/|g" "$HOME"/scripts/rclone-upload.sh
        fi
        sed -i "s|/homexx/yyyyy|$HOME|g" "$HOME"/.config/systemd/user/rclone-uploader.service
        sed -i "s|rcloneremote:|$remotename:|g" "$HOME"/.config/systemd/user/rclone-uploader.service
        echo ""
        echo "Choose the frequency of the uploader. Take note that the servers are located in the Netherlands, which is in the CET/CEST timezone. Examples below uses UTC for uniformity. You may choose between the following:"
        echo "Daily: Upload the contents of Local folder daily at 22:00 UTC with a randomized delay of +/- 30 minutes."
        echo "Weekly: Upload the contents of Local folder weekly at Monday, 22:00 UTC with a randomized delay of +/- 30 minutes."
        while true; do
            read -p "Enter 'daily' or 'weekly' here: " timerset
            case $timerset in
                daily)
                sed -i "s|dateset|daily|g" "$HOME"/.config/systemd/user/rclone-uploader.timer
                break
                ;;
                weekly)
                sed -i "s|dateset|weekly|g" "$HOME"/.config/systemd/user/rclone-uploader.timer
                break
                ;;
                *) echo "Unknown response. Try again..." ;;
            esac
        done
        echo "Do you want to start the rclone uploader service?"
        while true; do
            read -p "Type yes or no: " input2
            case $input2 in
                yes)
                echo "Starting Uploader service..."
                systemctl --user daemon-reload
                systemctl --user enable --now rclone-uploader.service
                systemctl --user enable --now rclone-uploader.timer
                break
                ;;
                no)
                systemctl --user daemon-reload
                echo "Will skip. Please run the following command to start the uploader service by yourself"
                echo ""
                echo "systemctl --user enable --now rclone-uploader.service && systemctl --user enable --now rclone-uploader.timer"
                echo ""
                sleep 7
                break
                ;;
            esac
        done
        break
        ;;
    normal)
        wget https://raw.githubusercontent.com/ultraseedbox/UltraSeedbox-Scripts/rclone-installer/MergerFS-Rclone/Upload%20Scripts/rclone-upload.sh -O "$HOME"/scripts/rclone-upload.sh
        if [ "$folconfig" = "custom" ]
        then
            sed -i -E "s|"\$HOME"/Stuff/Local/|$HOME/$stufffolder/$localfolder/|g" "$HOME"/scripts/rclone-upload.sh
        fi
        sed -i "s|rcloneremote:|$remotename:|g" "$HOME"/scripts/rclone-upload.sh
        echo ""
        echo "Choose the frequency of the uploader. Take note that the servers are located in the Netherlands, which is in the CET/CEST timezone. Examples below uses UTC for uniformity. You may choose between the following:"
        echo "Daily: Upload the contents of Local folder daily at 04:25 UTC with a delay of 5 minutes."
        echo "Weekly: Upload the contents of Local folder every Sunday, 04:47 UTC with a delay of 5 minutes."
        while true; do
            read -p "Enter 'daily' or 'weekly' here: " timerset
            case $timerset in
                daily)
                    echo "@daily $HOME/scripts/rclone-upload.sh >> /dev/null 2>&1" >> dailycron
                    crontab dailycron
                    rm dailycron
                    break
                    ;;
                weekly)
                    echo "@weekly $HOME/scripts/rclone-upload.sh >> /dev/null 2>&1" >> weeklycron
                    crontab weeklycron
                    rm weeklycron
                    break
                    ;;
                *)
                    echo "Unknown response. Try again..."
                    ;;
            esac
        done
        break
        ;;
    discord)
        wget https://raw.githubusercontent.com/ultraseedbox/UltraSeedbox-Scripts/rclone-installer/MergerFS-Rclone/Upload%20Scripts/rclone-upload-with-notification.sh -O "$HOME"/scripts/rclone-upload-with-notification.sh
        echo ""
        read -p "Enter your discord webhook: " dwebhook
        if [ "$folconfig" = "custom" ]
        then
            sed -i "s|$HOME/Stuff/Local/|$HOME/$stufffolder/$localfolder/|g" "$HOME"/scripts/rclone-upload-with-notification.sh
        fi
        sed -i "s|rcloneremote:|$remotename:|g" "$HOME"/scripts/rclone-upload-with-notification.sh
        sed -i "s|discordwebhook|$dwebhook|g" "$HOME"/scripts/rclone-upload-with-notification.sh
        sed -i "s|/homexx/yyyyy|$HOME|g" "$HOME"/scripts/rclone-upload-with-notification.sh
        echo "Choose the frequency of the uploader. Take note that the servers are located in the Netherlands, which is in the CET/CEST timezone. Examples below uses UTC for uniformity. You may choose between the following:"
        echo "Daily: Upload the contents of Local folder daily at 04:25 UTC with a delay of 5 minutes."
        echo "Weekly: Upload the contents of Local folder every Sunday, 04:47 UTC with a delay of 5 minutes."
        while true; do
            read -p "Enter 'daily' or 'weekly' here: " timerset
            case $timerset in
                daily)
                    echo "@daily $HOME/scripts/rclone-upload-with-notification.sh >> /dev/null 2>&1" >> dailycron
                    crontab dailycron
                    rm dailycron
                    break
                    ;;
                weekly)
                    echo "@weekly $HOME/scripts/rclone-upload-with-notification.sh >> /dev/null 2>&1" >> weeklycron
                    crontab weeklycron
                    rm weeklycron
                    break
                    ;;
                *)
                    echo "Unknown response. Try again..."
                    ;;
            esac
        done
        break
        ;;
    *)
        echo "Unknown response. Try again..."
        ;;
esac
done

clear

echo "Done. Run 'exec $SHELL' to complete installation."
cd "$HOME" || exit
# shellcheck disable=SC1090
source "$HOME"/.bash_aliases

# Quick man for vfs aliases
echo ""
echo "This script has installed the following aliases to manage your rclone vfs."
echo "Just type the following commands in your shell"
echo ""
echo "vfs-start = This starts the vfs mount."
echo "vfs-stop = This stops the vfs mount"
echo "vfs-restart = This restarts the vfs mount."
echo "vfs-upgrade = Upgrades your vfs mount to the latest revisions pushed out by USB."
echo "vfs-uploader-start = This starts the uploader service and upload the contents of Stuff/Local immediately."
echo "vfs-uploader-stop = This stops the uploader service."
echo "vfs-uploader-disable = This stops the uploader and disables it from automatically from automatically starting when the server reboots."

rm -- "$0"
exit