#!/bin/bash
video_path="/media/Robby/Videos/Footage_FauxMantleWithShelf/"

for f in $(find $video_path -name '*.MP4'); do
    new_f="${f%.MP4}.mov"
    ffmpeg -i "$f" -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov "$new_f"
done
