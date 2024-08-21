#!/usr/bin/env bash

###    PARSE POSITIONAL ARGS    ###
nxm_link=$1; shift

if [ -z "$nxm_link" ]; then
	echo "ERROR: please specify a NXM Link to download"
	exit 1
fi

nexus_game_id=${nxm_link#nxm://}
nexus_game_id=${nexus_game_id%%/*}
###    PARSE POSITIONAL ARGS    ###

instance_link="$HOME/.config/modorganizer2/${nexus_game_id:?}"
instance_dir=$(readlink -f  "$instance_link")
if [ ! -d "$instance_dir" ]; then
	[ -L "$instance_link" ] && rm "$instance_link"

	zenity --ok-label=Exit --error --text \
		"Could not download file because there is no Mod Organizer 2 instance for '$nexus_game_id'"
	exit 1
fi

#instance_dir_windowspath="Z:$(sed 's/\//\\\\/g' <<<$instance_dir)"
#pgrep -f "$instance_dir_windowspath\\\\ModOrganizer.exe"
#process_search_status=$?

bottle_id=$(cat "$instance_dir/bottle.txt")

echo "$nxm_link"
#if [ "$process_search_status" == "0" ]; then
	echo "INFO: sending download '$nxm_link' to running Mod Organizer 2 instance"
	download_start_output=$(flatpak run --command=bottles-cli com.usebottles.bottles run -b "$bottle_id" -e "$instance_dir/nxmhandler.exe" "'"$nxm_link"'")
	download_start_status=$?
#else
#	echo "INFO: starting Mod Organizer 2 to download '$nxm_link'"
#	download_start_output=$(flatpak run --command=bottles-cli com.usebottles.bottles run -b Skyrim -e "$instance_dir/ModOrganizer.exe" "$nxm_link")
#	download_start_status=$?
#fi

if [ "$download_start_status" != "0" ]; then
	zenity --ok-label=Exit --error --text \
		"Failed to start download:\n\n$download_start_output"
	exit 1
fi

