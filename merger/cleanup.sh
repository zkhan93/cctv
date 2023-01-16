#!/bin/bash
export TZ=Asia/Kolkata
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
DIR=$CLEANUP_DIR
LIMIT=$CLEANUP_SPACE
DEL_PATTERN=$CLEANUP_REGEX
SORT_KEY_AT=$CLEANUP_SORT_KEY
DELETED=0
echo "Running on $(date)"

if [[ ! "$DIR" =~ ^/out/ ]]; then
  echo "DIR does not started with /out quitting"
  exit 0
fi

AVAIL=$(df $DIR --output=avail | tail -n 1)
AVAIL_GB=$(($AVAIL/1024/1024))
echo "${AVAIL_GB} GB Available"
while [ $AVAIL_GB -lt $LIMIT ]; do
  echo "$LIMIT GB needed, need cleanup"
  FILE=$(find $DIR -type f -regex $DEL_PATTERN | sort -t / -k $SORT_KEY_AT | head -n 1)
  echo "removing $FILE"
  echo "$(du -h $FILE)"
  rm $FILE
  AVAIL=$(df $DIR --output=avail | tail -n 1)
  AVAIL_GB=$(($AVAIL/1024/1024))
  echo "${AVAIL_GB} GB Available"
  ((DELETED++))
done
echo "deleted $DELETED files"