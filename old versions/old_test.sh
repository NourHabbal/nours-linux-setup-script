#!/bin/bash

echo this is a test

prompt_message() {
	cat << EOF
==========
SETUP OPTIONS
----------
[ 1 ] hardware
[ 2 ] software
[ 3 ] resource check
[ 4 ] recommended folder hierarchy
[ 5 ] documentation
==========
pick a number: 
EOF
}

install_prompt() { 
	prompt_message
	read CHOICE
	case $CHOICE in
		1)	
			krita
			;;
		2)
			echo choice 2
			;;
		*)
			echo default choice
			;;
	esac
		
}

krita() {
	echo install krita? [ Y/N ]: 
	read PROMPT
	if [ ${PROMPT,,} = y ]; then
		clear
		echo entered block for krita installation
		## sudo dnf install krita
	elif [ ${PROMPT,,} = n ]; then
		echo entered block for krita install cancellation
	fi
	
	echo would you like to install a thumbnailer for krita and mypaint? youll see the images directly in your file manager without opening them
	read
}
install_prompt


; '
THE PLAN

run RESOURCE CHECK
scan what is currently there
prefix installed -> [ X ]
prefix not installed -> [ O ]


navigator -> setup type -> area -> software

SOFTWARE
	START
		flatpak
			flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
		gearlever (appimages)
			sudo dnf install gearlever
		boxes (VMs)
			sudo dnf install gnome-boxes
	2D ART TOOLS
		Krita -- great for texturing models, making artworks, animating, and pixel art. literally everything 2D
			sudo dnf install krita
		Krita Thumbnailer
			sudo install gnome-kra-ora-thumbnailer
	MODELING
		Blockbench [FLATPAK REQUIRED]
			flatpak install blockbench
		Blender
			sudo dnf install blender
		Bforartists [FLATPAK REQUIRED]
			sudo flatpak install bforartists
	MUSIC
		Yabridge [REQUIRES WINE 9.8 OR 9.4 STAGING]
			unavailable
		Ardour
			sudo dnf install ardour
		>> PROVIDE NOTES ON YABRIDGE ISSUE
	WRITING
		Vim
			sudo dnf install vim-enhanced
		RedNotebook
			sudo dnf install rednotebook
		Sticky Notes
			sudo dnf install stickynotes
	
	LIVING
		Passy -- password manager
			flatpak install passy
		Thunderbird	
			sudo dnf install thunderbird
		Foliate
			sudo dnf install foliate
		Blanket -- for good background noise
			sudo dnf install blanket
		Brave Browser
			sudo flatpak install brave
		Video Downloader
			sudo dnf install video-downloader
	GAMING
		Lutris
			DIRECTIONS: grab copies of the emulator images from the scripts resource folder
			sudo dnf install lutris
		Bottles
			sudo dnf install bottles
		

HARDWARE	
	**SETUP ROG LAPTOP**
		sourced from [this guide](https://asus-linux.org/guides/fedora-guide/)
		[PT 1]
		sudo dnf update
		sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
		
		[PT 2]
		sudo dnf update
		sudo dnf install kernel-devel
		sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda
		wait 5 minutes
		
		[PT 3]
		sudo systemctl enable nvidia-hibernate.service nvidia-suspend.service nvidia-resume.service nvidia-powerd.service
		
		[PT 4]
		reboot
		
		[PT 5]
		this must return Y: sudo cat /sys/module/nvidia_drm/parameters/modeset
		
		sudo dnf copr enable lukenukem/asus-linux
		sudo dnf update
		sudo dnf install asusctl supergfxctl
		sudo dnf update --refresh
		sudo systemctl enable supergfxd.service
		sudo dnf install asusctl-rog-gui

		[PT 6]
		reboot
		
		[PT 7] FOR DBUS ERRORS ONLY!!
        	sudo modprobe asus-nb-wmi
        	sudo systemctl start asusd.service
        	
        	the gui should work with this fix
        	(source: asus-linux discord)
        	
        	WARNING:
		disabling keyboard lights with asus utils disables it across all installed operating systems
		the keyboard will stay off even if you remove the software or the OS containing it! (unless you re-install linux and the utils to re-toggle them)
		thats what you get when you dual boot :(

RESOURCE CHECK in install script directory
	check if browser bookmarks are saved
	check if install script of intelliJ is there
	check if emulator files are there
	check if passy password backups are there
	check if your wanted music is there

EXPORT DATA FOR NEXT SETUP (direct the user)
	request backing up browser bookmarks, naming them in this format:
		PASSWORD-YYYY-MM-DD-BROWSERNAME
	request to export passy files, naming to this format:
		PASSWORD-YYYY-MM-DD-PASSY
	check if emulator files are there
	check if intelliJ script is there, if not request to get the install script from website


RECOMMENDED DOCUMENTS FOLDER HIERARCHY
	Documents
		00-inbox
		01-projectpages
		02-mycurrentwork
			02.01 experimental
			02.02 
		03-miscdata
		04-old
	
Nours Install Script
	setup.sh
	[data]
		[bookmarks]
			[app-name]
				BOOKMARK-2022-05-07-APP-NAME.zip
		[passwords]
			[app-name]
				PASSWORD-2024-04-23-APP-NAME.zip
		[music]
		[installs]
			citra.appimage
			yuzu.appimage
			ryujinx.appimage
			[intelliJ files]
		[lists]
			mymusic.txt
			myinstallfiles.txt
		
	
'
