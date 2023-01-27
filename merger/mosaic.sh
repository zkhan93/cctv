#!/bin/bash
export TZ=Asia/Kolkata
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/

MDAYS=$1
DIR=$2
DATE=$(date +"%d-%m-%Y" -d "$MDAYS days ago")
echo "Running on $(date) - for ${DATE}"

OUT_VID="${DIR}/${DATE}_mosaic.mkv"
if [ -f $OUT_VID ]; then
  echo "mosaic file '$OUT_VID' already exists! quitting"
  exit
fi

IN_VID1="${DIR}/cam1/${DATE}_cam1_timelapse.mkv"
IN_VID2="${DIR}/cam2/${DATE}_cam2_timelapse.mkv"
IN_VID3="${DIR}/cam3/${DATE}_cam3_timelapse.mkv"
IN_VID4="${DIR}/cam4/${DATE}_cam4_timelapse.mkv"

if [ ! -f $IN_VID1 ]; then
  echo "source file '$IN_VID1' does not exists! using nullsrc"
  IN_VID1=nullsrc=size=960x540
fi
if [ ! -f $IN_VID2 ]; then
  echo "source file '$IN_VID2' does not exists! using nullsrc"
  IN_VID2=nullsrc=size=960x540
fi
if [ ! -f $IN_VID3 ]; then
  echo "source file '$IN_VID3' does not exists! using nullsrc"
  IN_VID3=nullsrc=size=960x540
fi
if [ ! -f $IN_VID4 ]; then
  echo "source file '$IN_VID4' does not exists! using nullsrc"
  IN_VID4=nullsrc=size=960x540
fi


echo "mosaic file does not exists, proceeding to create one"
ffmpeg -loglevel error -i $IN_VID1 -i $IN_VID2 -i $IN_VID3 -i $IN_VID4 -filter_complex "nullsrc=size=640x480 [base]; [0:v] setpts=PTS-STARTPTS, scale=320x240 [upperleft]; [1:v] setpts=PTS-STARTPTS, scale=320x240 [upperright]; [2:v] setpts=PTS-STARTPTS, scale=320x240 [lowerleft]; [3:v] setpts=PTS-STARTPTS, scale=320x240 [lowerright]; [base][upperleft] overlay=shortest=1 [tmp1]; [tmp1][upperright] overlay=shortest=1:x=320 [tmp2]; [tmp2][lowerleft] overlay=shortest=1:y=240 [tmp3]; [tmp3][lowerright] overlay=shortest=1:x=320:y=240" -c:v libx264 $OUT_VID
echo "mosaic video created at $OUT_VID"

