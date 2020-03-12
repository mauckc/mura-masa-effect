#!/bin/sh

# Move into images directory
cd images

# Count number of input images
shopt -s nullglob
num_files=`set -- *.HEIC; echo "$#"`
echo "[INFO]: Number of files input files in the images directory: "$num_files
total_num_files=$((2*$num_files-1))
echo "[INFO]: Total number of images in the output gif: "$total_num_files

# Start image counter
counter=1

# Process each input image
for f in *.HEIC
do
    echo $f
    # convert image to jpg
    magick convert $f image$counter.jpg &&
    # Copy input file to reverse direction
    cp image$counter.jpg image$total_num_files.jpg
    # update counters
    counter=$(($counter+1))
    total_num_files=$(($total_num_files-1))
done

# Process images to video
ffmpeg -f image2 -framerate 9 -i image%d.jpg -vf scale=480:-1 ../out.gif

echo "[INFO]: Cleaning up temporary files..."
rm image* && echo "[INFO]: Finished. "
