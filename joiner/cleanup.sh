#!/bin/bash
CAMID=$1
DIR=$2
DAYS=$3

n=$(ls $DIR/${CAM_ID}* -tr | egrep "*-[0-9]{2}.mp4" | wc -l)
echo "have recording for past $n days"
if [ $n -gt $DAYS ] ; then
  echo "deleting"
  for f in $(ls $DIR/${CAM_ID}* -tr | egrep "*-[0-9]{2}.mp4" | head -n -$DAYS) ; do
   echo $f
   rm $f
  done
fi
echo "done"
