#!/bin/sh
cd images

shopt -s nullglob

echo $FILES 
num_files=`set -- *.HEIC; echo "$#"`
total_num_files=$((2*$num_files-1))
counter=1
echo $total_num_files
for f in *.HEIC
do
    echo $f
    magick convert $f image$counter.jpg &&
    cp image$counter.jpg image$total_num_files.jpg
    counter=$(($counter+1))
    total_num_files=$(($total_num_files-1))
    echo $total_num_files
done


# magick mogrify -monitor -format jpg *.HEIC

ffmpeg -f image2 -framerate 9 -i image%d.jpg  ../out.gif

rm image*
