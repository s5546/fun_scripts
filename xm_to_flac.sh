#!/bin/bash
#requires ffmpeg, available from repos
for i in *.xm
do 
	ffmpeg -i "$i" -c:a flac "${i%.*}.flac"
done
