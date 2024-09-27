#!/bin/bash

launch ()
{
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

pgrep polybar | xargs -L1 kill; launch
