#! /bin/bash

PREFIX=$(date +%Y-%m-%d-%H-%M-%S)
BAGS=/home/hrc/koch_robot_arm/bags/$(date +%Y_%m%d_%H%M)

if [ ! -d "$BAGS" ]; then
    mkdir -m 775 -p $BAGS
fi

BAGS=$BAGS"/"$PREFIX
echo "BAGS: "$BAGS

ros2 bag record -o $BAGS \
    /camera/camera_firsst/color/image_raw/compressed \
    /camera/camera_firsst/aligned_depth_to_color/image_raw/compressedDepth\
    /camera/camera_firsst/color/camera_info \
    /left_follower/joint_states \
    /left_leader/joint_states\
    /right_follower/joint_states \
    /right_leader/joint_states \
    /camera/camera_top/color/image_raw/compressed \
    /camera/camera_top/aligned_depth_to_color/image_raw/compressedDepth \
    /camera/camera_top/color/camera_info



