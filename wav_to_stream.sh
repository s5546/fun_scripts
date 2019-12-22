#!/bin/bash
#converts all wav files in directory to stream files, used for payday 2 (and probably other games)
#uses the payday 2 sound converter, developed by Anton Pupkov:
#https://bitbucket.org/zabb65/payday-2-modding-information/downloads/sound_conveter_v1.15.zip
#(if you cant find a working link, message me somehow)
#windows executable only
#...yeah im using a linux subsystem for windows, maybe it'd work in WINE tho (or a VM)

for f in "*.wav"
do 
	./wwise_ima_adpcm.exe -e "$f" "$f"
done
