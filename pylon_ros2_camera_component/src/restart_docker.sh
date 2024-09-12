#!/bin/bash

# Serial IDs for cameras
FRONT_LEFT_SERIAL_ID="40525211"
FRONT_RIGHT_SERIAL_ID="40525410"

# Camera names
FRONT_LEFT_NAME="cam_front_left"
FRONT_RIGHT_NAME="cam_front_right"
TARGET_ID="2676:ba05"

CONTAINER_ID_LEFT=$(docker ps -q --filter "ancestor=bhf_stack_testing-basler_camera_front_left")
CONTAINER_ID_RIGHT=$(docker ps -q --filter "ancestor=bhf_stack_testing-basler_camera_front_right")
# USB Target ID for identifying cameras (uncomment if needed)
# TARGET_ID="2676:ba05"

# Infinite loop to check camera status
while true; do
    # Extract camera serial number using lsusb and awk
    cameras=$(lsusb -v -d "$TARGET_ID" 2>/dev/null | grep -i "iSerial" | awk '{print $3}')
    
    # Check if the argument matches the camera name and serial ID
    if [ "$1" = "$FRONT_LEFT_NAME" ] && [ "$cameras" = "$FRONT_LEFT_SERIAL_ID" ]; then
        echo "LEFT"
        docker restart "$CONTAINER_ID_LEFT" 
        break
    elif [ "$1" = "$FRONT_RIGHT_NAME" ] && [ "$cameras" = "$FRONT_RIGHT_SERIAL_ID" ]; then
        echo "RIGHT"
        docker restart "$CONTAINER_ID_RIGHT" 
        break
    fi
done


