#!/bin/sh
#export TZ=Asia/Kolkata
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
echo $(date)
#NAME=$1
#DURATION=$2
#RTSP_URL=$3
#FORMAT=$4
#SEGMENT_FORMAT=$5
#TIMEOUT_BUFFER=$6
if [ ! -e /out/$NAME ]; then
  mkdir /out/$NAME
fi
chmod 775 /out/$NAME
TIMEOUT=$(( $DURATION + $TIMEOUT_BUFFER ))

while true
do
echo "started at $(date)"
echo "should timeout after $DURATION"
timeout --kill-after $TIMEOUT_BUFFER -v $DURATION \
ffmpeg -nostdin -loglevel $LOG_LEVEL \
-y -i $RTSP_URL -timeout 60000000 \
-vsync 1 -async -1 -an -vcodec copy \
-t $DURATION \
-f segment -strftime 1 -segment_time $DURATION \
-segment_format $FORMAT "/out/${NAME}/${SEGMENT_FORMAT}_${NAME}.$FORMAT" \
-reset_timestamps 1 -segment_atclocktime 1 

echo "stopped at $(date)"
sleep 2;
done
