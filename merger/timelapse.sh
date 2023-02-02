#!/bin/bash
export TZ=Asia/Kolkata
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
MDAYS=$1
DIR=$2
CAMID=$(basename $DIR)
DATE=$(date +"%d-%m-%Y" -d "$MDAYS days ago")
IN_VID="$DIR/${DATE}_${CAMID}.mkv"
OUT_VID="$DIR/${DATE}_${CAMID}_timelapse.mkv"

echo "Running on $(date) - for ${DATE}"

if [ ! -f $IN_VID ]; then
  echo "source file '$IN_VID' does not exists! quitting"
  exit
fi

if [ -f $OUT_VID ]; then
  echo "timelapse file '$OUT_VID' already exists! quitting"
  exit
fi

echo "timelapse file does not exists, proceeding to create one"
ffmpeg -loglevel error -i $IN_VID -an -filter:v "setpts=PTS/60" $OUT_VID
echo "timelapse video created at $OUT_VID"

TIMELAPSE_PATH_FOR_UPLOADER="/external/$CAMID/$DATE_$CAMID_timelapse.mkv"
echo "submit a task to upload the file to youtube $TIMELAPSE_PATH_FOR_UPLOADER"
/app/upload.sh "$CAMID ${DATE} Timelapse" "$TIMELAPSE_PATH_FOR_UPLOADER";
echo "task submitted"
