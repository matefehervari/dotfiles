#!/bin/bash


launch ()
{
# for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#   MONITOR=$m polybar --config="/home/mate/.config/polybar/config.ini" -r \
#     bar 2>&1 | tee -a /tmp/polybar1.log & 
#   echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# done
monitor=$($HOME/Scripts/getcurrentmonitor.sh)
echo $monitor
MONITOR=$monitor polybar --config="/home/mate/.config/polybar/config.ini" -r \
    bar 2>&1 | tee -a /tmp/polybar1.log & 
  echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
}

killall -o 5s polybar; launch
