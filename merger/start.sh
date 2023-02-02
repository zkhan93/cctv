#! /bin/bash

/app/cleanup.sh

echo "starting to merge videos for last 10 days"
for day in {1..10}; do
	for d in /out/*; do
		if [ -d "$d" ]; then
			/app/merge.sh $day "$d";
		fi 
	done
done
echo "merging complete"

echo "generate timelapse video for last 3 days"
for day in {1..3}; do
	for d in /out/*; do
		if [ -d "$d" ]; then
			/app/timelapse.sh $day "$d";
		fi 
	done
done
echo "timelapse generation complete"

echo "creating mosaic video"
for day in {1..2}; do
	/app/mosaic.sh $day /out;
done
