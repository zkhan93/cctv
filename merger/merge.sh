#!/bin/bash
export TZ=Asia/Kolkata
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
CAMID=$1
MDAYS=$2
DIR=$3
DATE=$(date +"%d-%m-%Y" -d "$MDAYS days ago")
OUT="$DIR/${CAMID}_${DATE}.txt"
DELETE="$DIR/del_${CAMID}_${DATE}.txt"
MERGED_TMP="$DIR/${DATE}_${CAMID}_tmp.mkv"
MERGED="$DIR/${DATE}_${CAMID}.mkv"

echo "Running on $(date) - for ${DATE}"

if [ -f "$OUT" ]; then
 rm $OUT
fi

for f in $DIR/${DATE}_*_${CAMID}.mkv; do
   if ffprobe -loglevel warning $f; then
     echo "file '$f'" >> $OUT
   else
    echo "corrupted file '$f' ignored"
   fi
   echo "$f" >> $DELETE
done


cat $OUT
LINES=$(wc -l < $OUT)
if [ $LINES -ge "2" ]; then
  echo "merging videos"
  ffmpeg -loglevel error -f concat -safe 0 -i $OUT -c copy $MERGED_TMP
  echo "videos merged to $MERGED_TMP"

  if [ $? -eq 0 ] && [ -f $MERGED_TMP ] ; then
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

echo "convert to 720p"
ffmpeg -loglevel error -i $MERGED_TMP -filter:v "scale=-1:720" $MERGED
if [ $? -eq 0 ] && [ -f $MERGED ] ; then
  echo "vide converted to 720 $MERGED"
  echo "deleting original video"
  rm "$MERGED_TMP"
fi