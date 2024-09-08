#!/bin/bash

ORIG_X=1920
ORIG_Y=1080

# OFFSET_WIDTH=120
OFFSET_WIDTH=122 # 10/05/2024

NEW_X=$(($ORIG_X - $OFFSET_WIDTH))
NEW_Y=1080
LENGTH_X=344
LENGTH_Y=193
let NEW_LENGTH_X=(NEW_X*LENGTH_X/ORIG_X)
REMAINING_LENGTH_X=$(($LENGTH_X - $NEW_LENGTH_X))

DUAL_X_OFFSET=$(($ORIG_X + $OFFSET_WIDTH))

MONO_OFFSET=$OFFSET_WIDTH+0
DUAL_OFFSET="$DUAL_X_OFFSET"+0
NEW_MON_RES="$NEW_X"/"$NEW_LENGTH_X"x"$NEW_Y/$LENGTH_Y"
REMAINING_MON_RES="$OFFSET_WIDTH"/"$REMAINING_LENGTH_X"x"$NEW_Y"/"$LENGTH_Y"

DP1_dim="$(xrandr | grep -o -P "^DP-1 (connected|disconnected) (primary )?\K(\d+|x|\+)+")"
echo $DP1_dim
if [ $DP1_dim ]; then
  # xrandr --setmonitor eDP-1~1 1798/322x1080/193+2044+0 eDP-1
  xrandr --setmonitor eDP-1~1 $NEW_MON_RES+$DUAL_OFFSET eDP-1
  xrandr --setmonitor eDP-1~2 $REMAINING_MON_RES+$ORIG_X+0 none
else
  xrandr --setmonitor eDP-1~1 $NEW_MON_RES+$MONO_OFFSET eDP-1
  xrandr --setmonitor eDP-1~2 $NEW_MON_RES+$0+0 none
fi
xrandr --output eDP-1 --primary
