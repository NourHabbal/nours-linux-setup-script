#!/bin/bash

setup_msg() {
	clear
	cat << EOF
==========
SETUP OPTIONS
----------
[ 1 ] hardware optimization -- in progress
[ 2 ] software installs -- in progress
[ 3 ] resource check -- TBD
[ 4 ] recommended folder hierarchy -- TBD
[ 5 ] documentation -- TBD
[ 6 ] import my music

[ X ] exit
==========
pick a character: 
EOF
}

hardware_opt_msg() {
	echo not finished here yet
}



software_msg() {
	clear
	cat << EOF
==========
SOFTWARE
----------
[ 1 ] compatibility -- in progress
[ 2 ] art tools -- in progress
[ 3 ] gaming -- TBD
[ X ] exit
[ Y ] go up
==========
pick a character: 
EOF
}


setup() {
	setup_msg
	read CHOICE
	case ${CHOICE,,} in
		1)
			hardware_opt
			;;
		2)
			software
			;;
		6)
			exit
			;;
		x) 
			exit
			;;
		*)
			setup
			;;
	esac
}

hardware_opt() {
	hardware_opt_msg
	setup
}



software() {
	software_msg
	
	read CHOICE
	case ${CHOICE,,} in 
		1)
			clear
			flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
			sudo dnf install gnome-boxes
			sudo flatpak install it.mijorus.gearlever
			;;
		2)
			clear
			echo install krita and kra-ora thumbnailer [ Y/N ]?
			read KRITA_PREFERENCE
			if [ ${KRITA_PREFERENCE,,} = y ]; then
				sudo dnf install krita gnome-kra-ora-thumbnailer 
			else
				echo krita installation cancelled
			fi
			
			clear
			echo install [ 1 ] blender or [ 2 ] bforartists, or [ 3 ] both?
			read BLENDER_PREFERENCE
			if [ $BLENDER_PREFERENCE = 1 ]; then
				sudo dnf install blender
			elif [ $BLENDER_PREFERENCE = 2 ]; then
				sudo flatpak install de.bforartists.Bforartists
			elif [ $BLENDER_PREFERENCE = 3 ]; then
				sudo dnf install blender
				sudo flatpak install de.bforartists.Bforartists
			else
				echo blender installation cancelled
			fi
			
			clear
			echo install blockbench? [ Y/N ]
			read BLOCKBENCH_PREFERENCE
			if [ ${BLOCKBENCH_PREFERENCE,,} = y ]; then
				sudo flatpak install net.blockbench.Blockbench 
			else
				echo blockbench installation cancelled
			fi
			;;
		3)
			echo install lutris [ Y/N ]?
			read LUTRIS_PREFERENCE
			if [ ${LUTRIS_PREFERENCE,,} = y ]; then
				sudo dnf install lutris 
			else
				echo lutris installation cancelled
			fi
			
			clear
			echo install bottles [ Y/N ]?
			read BOTTLES_PREFERENCE
			if [ ${BOTTLES_PREFERENCE,,} = y ]; then
				sudo dnf install bottles 
			else
				echo bottles installation cancelled
			fi
			;;
		x)
			exit
			;;
		y)
			setup
			;;
	esac
	software
}
setup


