#!/bin/bash


launch ()
{
# for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#   MONITOR=$m polybar --config="/home/mate/.config/polybar/config.ini" -r \
#     bar 2>&1 | tee -a /tmp/polybar1.log & 
#   echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# done
#

monitors=$(xrandr | grep -Po "^\S+ connected" | cut -d " " -f 1)
primary=$(xrandr | grep -P "primary" | cut -d " " -f 1)
for monitor in $monitors; do
  if [[ $monitor == $primary ]]; then
    MONITOR=$monitor polybar --config="/home/mate/.config/polybar/config.ini" -r \
        primary 2>&1 | tee -a /tmp/polybar1.log & 
  else
    MONITOR=$monitor polybar --config="/home/mate/.config/polybar/config.ini" -r \
        secondary 2>&1 | tee -a /tmp/polybar1.log & 
  fi
done
}

killall -o 5s polybar; launch
