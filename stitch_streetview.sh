#!/bin/bash

# stitch street view tiles together!

for i in `seq 0 3`;
do
  montage -mode concatenate -tile 7x1 tile_3_*_$i.jpg row_$i.jpg
done

montage -mode concatenate -tile 1x4 row_0.jpg row_1.jpg row_2.jpg row_3.jpg stitched.jpg

rm row*jpg
