# #!bin/bash

# TARGET_ID="2676:ba05"
FRONT_LEFT_SERIAL_ID="40525211"
FRONT_RIGHT_SERIAL_ID="40525210"

FRONT_LEFT_NAME="cam_front_left"
FRONT_RIGHT_NAME="cam_front_right"



# FRONT_LEFT_OFF="false"
# FRONT_RIGHT_OFF="false"


while true; do

    #echo "HELLO"
    cameras=$(lsusb -v -d "$TARGET_ID" 2>/dev/null | grep -i "iSerial" | awk '{print $3, $4}')

    echo "HELLO"
    if ["$1" = "$FRONT_LEFT_NAME"] || ["$cameras" = "$FRONT_LEFT_SERIAL_ID"]; then
        echo "LEFT"
        break
    elif ["$1" = "$FRONT_RIGHT_NAME"] || ["$cameras" = "$FRONT_RIGHT_SERIAL_ID"]; then
        echo "RIGHT"
        break
    fi
done
