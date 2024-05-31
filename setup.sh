#!/bin/bash

JOB_FILE=commands.txt

PACKAGES=("it.mijorus.gearlever" "krita gnome-kra-ora-thumbnailer" "blender" "net.blockbench.Blockbench" "de.bforartists.Bforartists" "lutris" "bottles" "video-downloader" "thunderbird" "com.brave.Browser")

refresh_job_file

execute_jobs() {
	clear
	echo the following jobs will be executed:
	cat $JOB_FILE
	echo
	read -p "are you sure you want to make these changes? [ Y/N ]: " PROMPT
	
	if [ ${PROMPT,,}=y ]; then
		while IFS= read -r command; do
        		eval $command
    		done < $JOB_FILE
    	elif [ ${PROMPT,,}=n ]; then
    		exit
    	fi
    	## i don't understand this code
}

list_package_status() {
	for i in ${!PACKAGES[@]}
	do
		package=${PACKAGES[$i]}
		if dnf list installed $package &>/dev/null || flatpak list | grep -q $package; then
			echo [ - ] $package
		else
			echo [ $i ] $package
		fi
	done
}

message(){
	clear
	echo ====================
	echo SETUP OPTIONS
	echo --------------------
	
	echo [ ROG ] setup ROG software
	
	## loop software options
	list_package_status
	
	## actions
	echo
	echo [ X ] cancel and exit
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


add_job() {
	## check if available in dnf or flatpak
	if dnf search $1; then
		echo adding dnf job
		echo sudo dnf install $1 -y >> $JOB_FILE
	elif flatpak search $1; then
		echo adding flatpak job
		echo sudo flatpak install $1 -y >> $JOB_FILE
	else 
		echo could not find package in dnf and flatpak repos [ ERROR 1 ]
	fi
}
ask_to_continue() {
	read -p "would you like to continue the setup? [ Y/N ] " INPUT2
	if [ ${INPUT2,,}=y ]; then
		echo -n > $JOB_FILE
		menu
	fi
}

menu() {
	message
	read -p "select an option: " INPUT
	case ${INPUT,,} in
		[0-9])
			add_job ${PACKAGES[${INPUT}]} ## referencing array elements wrong gives errors
			;;
		x)
			## exit
			echo > $JOB_FILE
			exit
			;;
		start)	
			## execute jobs
			execute_jobs
			menu
			;;
		rog)
			echo this sections a dud
			;;
		*)
			menu
			;;
	esac
	menu
}
echo adding flathub repo if not available

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
menu

