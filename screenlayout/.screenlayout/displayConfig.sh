#!/bin/bash

DP1_dim="$(xrandr | grep -o -P "^DP-1 (connected|disconnected) (primary )?\K(\d+|x|\+)+")"
HDMI_connected="$(xrandr | grep -o -P "^HDMI-1 \K(connected|disconnected)")"

if [ -z $DP1_dim ]; then
  HDMI_pos=0x0
else
  HDMI_pos=1920x0
fi


if [ "$HDMI_connected" == "connected" ]; then
  xrandr --output HDMI-1 --mode 1920x1080 --pos "$HDMI_pos" --rotate normal 
else 
  xrandr --output HDMI-1 --off
fi

feh --bg-fill $WALLPAPER

currmon=$($HOME/Scripts/getcurrentmonitor.sh)
if [[ $currmon=eDP-1~1 ]]; then
  xrandr --delmonitor eDP-1~2
fi

# /home/mate/.config/polybar/polylaunch.sh
notify-send -t 5000 "$(xrandr --listactivemonitors)"

$HOME/.config/polybar/polylaunch.sh 
