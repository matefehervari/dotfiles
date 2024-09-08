#!/bin/bash

currmon=$($HOME/Scripts/getcurrentmonitor.sh)
DP1_dim="$(xrandr | grep -o -P "^DP-1 (connected|disconnected) (primary )?\K(\d+|x|\+)+")"

xrandr --delmonitor eDP-1~1
xrandr --delmonitor eDP-1~2

xrandr --current \
  --output eDP-1 --mode 1920x1080 --pos 1920x0 --rotate normal \
  --output HDMI-1 --off \
  --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal \
  --output DP-2 --off

if [ $currmon="eDP-1~1" ] && [ -z $DP1_dim ]; then
  $HOME/Scripts/screenoffset.sh
fi
