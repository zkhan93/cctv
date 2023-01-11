#! /bin/bash

# make sure enough space is available
/app/cleanup.sh /out/ '.*-[0-9]+_cam[0-9].*' 4

# merge recorded clips from past days 
echo "starting to merge videos for last 10 days"
for day in {1..10}; do
	/app/merge.sh cam1 $day /out/cam1;
	/app/merge.sh cam2 $day /out/cam2;
	/app/merge.sh cam3 $day /out/cam3;
	/app/merge.sh cam4 $day /out/cam4;
	/app/merge.sh cam5 $day /out/cam5;
done
echo "mergeing complete"

# generate timelapse for recorded days 
echo "generate timelapse video for last 3 days"
for day in {1..3}; do
       /app/timelapse.sh cam1 $day /out/cam1;
       /app/timelapse.sh cam2 $day /out/cam2;
       /app/timelapse.sh cam3 $day /out/cam3;
       /app/timelapse.sh cam4 $day /out/cam4;
       /app/timelapse.sh cam5 $day /out/cam5;
done
echo "timelapse generation complete"

echo "creating mosaic video"
for day in {1..2}; do
	/app/mosaic.sh $day /out/;
done
