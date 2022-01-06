#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
CAMID=$1
MDAYS=$2
DIR=$3
DATE=$(date +"%Y-%m-%d" -d "$MDAYS days ago")
OUT="$DIR/${CAMID}_${DATE}.txt"
DELETE="$DIR/del_${CAMID}_${DATE}.txt"
MERGED="$DIR/${CAMID}_${DATE}.mp4"
if [ -f "$OUT" ]; then
 rm $OUT
fi

for f in $DIR/${CAMID}_${DATE}_*; do
 echo "file '$f'" >> $OUT
 echo "$f" >> $DELETE
done

LINES=$(wc -l < $OUT)
if [ $LINES -ge "2" ]; then
  echo "merging videos"
  /usr/local/bin/ffmpeg -f concat -safe 0 -i $OUT -c copy $MERGED
  echo "videos merged to $MERGED"
  if [ $? -eq 0 ]; then
    echo "deleting segment videos"
    for f in $(cat $DELETE) ; do 
      rm "$f"
    done
  fi
fi
if [ -f $OUT ]; then
  rm $OUT
fi
if [ -f $DELETE ]; then
  rm $DELETE
fi
