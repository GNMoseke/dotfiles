#!/bin/bash

# Taken and slightly modified from https://github.com/adi1090x/widgets/blob/main/eww/dashboard/scripts/music_info

## Get data
STATUS="$(mpc status)"
COVER="/tmp/.music-cover.jpg"
MUSIC_DIR="$HOME/Music"

## Get status
get_status() {
	if [[ $STATUS == *"[playing]"* ]]; then
		echo ""
	else
		echo ""
	fi
}

## Get song
get_song() {
	song=`mpc -f %title% current`
	if [[ -z "$song" ]]; then
		echo "Unknown Track"
	else
		echo "$song"
	fi	
}

## Get artist
get_artist() {
	artist=`mpc -f %artist% current`
	if [[ -z "$artist" ]]; then
		echo "Unknown Artist"
	else
		echo "$artist"
	fi	
}

get_album() {
	album=`mpc -f %album% current`
	if [[ -z "$album" ]]; then
		echo "Unknown Album"
	else
		echo "$album"
	fi	
}

## Get cover
get_cover() {
	ffmpeg -i "${MUSIC_DIR}/$(mpc current -f %file%)" "${COVER}" -y &> /dev/null
	STATUS=$?

	# Check if the file has a embbeded album art
	if [ "$STATUS" -eq 0 ];then
		echo "$COVER"
	else
		echo "images/music.png"
	fi
}

## Execute accordingly
if [[ "$1" == "--song" ]]; then
	get_song
elif [[ "$1" == "--artist" ]]; then
	get_artist
elif [[ "$1" == "--album" ]]; then
	get_album
elif [[ "$1" == "--status" ]]; then
	get_status
elif [[ "$1" == "--cover" ]]; then
	get_cover
elif [[ "$1" == "--toggle" ]]; then
	mpc -q toggle
elif [[ "$1" == "--next" ]]; then
	{ mpc -q next; get_cover; }
elif [[ "$1" == "--prev" ]]; then
	{ mpc -q prev; get_cover; }
fi
