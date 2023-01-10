#!/bin/bash
export TZ=Asia/Kolkata
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
DIR=$1
LIMIT=45
DEL_PATTERN=$2 # '.*-[0-9]+_cam[0-9]\..*'
SORT_KEY_AT=$3
MAX_DELETE=10
echo "Running on $(date)"

if [[ ! "$DIR" =~ ^/out/ ]]; then
  echo "DIR does not started with /out quitting"
  exit 0
fi

AVAIL=$(df $DIR --output=avail | tail -n 1)
AVAIL_GB=$(($AVAIL/1024/1024))
echo "${AVAIL_GB} GB Available"
while [ $AVAIL_GB -lt $LIMIT ] && [ $MAX_DELETE -gt 0 ] ; do
  echo "$LIMIT GB needed, need cleanup"
  FILE=$(find $DIR -type f -regex $DEL_PATTERN | sort -t / -k $SORT_KEY_AT | head -n 1)
  echo "removing $FILE"
  echo "$(du -h $FILE)"
  rm $FILE
  AVAIL=$(df $DIR --output=avail | tail -n 1)
  AVAIL_GB=$(($AVAIL/1024/1024))
  echo "${AVAIL_GB} GB Available"
  ((MAX_DELETE--))
  echo $MAX_DELETE
done
