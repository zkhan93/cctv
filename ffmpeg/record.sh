#!/bin/bash
#NAME=$1
#DURATION=$2
#RTSP_URL=$3
#FORMAT=$4
#SEGMENT_FORMAT=$5
#TIMEOUT_BUFFER=$6
if [[ ! -e /out/$NAME ]]; then
  mkdir /out/$NAME
fi
chmod 775 /out/$NAME
TIMEOUT=$(( $DURATION + $TIMEOUT_BUFFER ))
echo timeout $TIMEOUT \
ffmpeg  -loglevel $LOG_LEVEL \
-y -i $RTSP_URL -stimeout 60000000 \
-vsync 1 -async -1 -an -vcodec copy \
-f segment -strftime 1 -segment_time $DURATION -segment_format $FORMAT "/out/${NAME}/${NAME}_${SEGMENT_FORMAT}.$FORMAT" -reset_timestamps 1 -segment_atclocktime 1

