#!/bin/bash

JOB_FILE=commands.txt

clear_jobs() {
	echo -n $JOB_FILE
}

execute_jobs() {
	clear
	echo the following jobs will be executed:
	cat $JOB_FILE
	echo
	sleep 1
	
	read -p "are you sure you want to make these changes? [ Y/N ]: " PROMPT
	sleep 2
    	if [ ${PROMPT,,}=y ]; then
		while IFS= read -r command; do
        		eval $command
    		done < $JOB_FILE
    	else
    		echo cancelled installation
    		clear_jobs
    	fi
    	
    	## theres a bug here
}

message(){
	clear
	echo ====================
	echo SETUP OPTIONS
	echo --------------------
	
	echo [ 1 ] add flathub repo and gearlever to make this scripts apps work
	echo [ 2 ] setup ROG software
	echo [ 3 ] setup modeling software
	echo [ 4 ] setup 2D art software
	echo [ 5 ] setup entertainment software
	
	echo [ X ] exit
	echo [ START ] apply changes
	
	echo -------------------- 
	echo the following jobs will be applied: 
	if [ -s ${JOB_FILE} ]; then 
		cat $JOB_FILE ## if file is not empty
	else
		echo no changes applied
	fi
	echo
	echo -=-=-=-=-=-=-=-=-=-=
}
menu() {
	message
	read -p "select an option: " INPUT
	case ${INPUT,,} in
		1)
			flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
			sudo flatpak install it.mijorus.gearlever
			;;
		2)
			echo this sections a dud
			;;
		3)
			echo sudo dnf install blender -y >> $JOB_FILE
			echo sudo flatpak install net.blockbench.Blockbench -y >> $JOB_FILE
			;;
		4)
			echo sudo dnf install krita gnome-kra-ora-thumbnailer -y >> $JOB_FILE 
			
			;;
		5)
			sudo dnf install bottles atlauncher supertuxkart lutris -y >> $JOB_FILE
			;;
		x)
			clear_jobs
			exit
			;;
		start)
			execute_jobs
			;;
		*)
			menu
			;;
	esac
	menu
}

menu

