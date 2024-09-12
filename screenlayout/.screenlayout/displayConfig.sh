#!/bin/bash

feh --bg-fill $WALLPAPER
notify-send -t 5000 "$(xrandr --listactivemonitors)"

SHOULD_EXEC_POLYBAR=$1
if [[ $1 != "nopolybar" ]]; then
  $HOME/.config/polybar/polylaunch.sh
fi
