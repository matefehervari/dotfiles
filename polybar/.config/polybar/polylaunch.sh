#!/bin/bash

while getopts "m:" flag
do
    case "$flag" in
        m)
            num_mon=$OPTARG
        ;;
    esac
done

function num_mons {
    xrandr --listactivemonitors | tail -n +2 | wc -l
}

launch ()
{
    if [[ $num_mon ]]; then
    while [[ $num_mon != $(num_mons) ]]; do
        notify-send "num mon not equal to $num_mon"
        sleep .5
    done
        notify-send "num mon equal to $num_mon"
    fi

  
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

polybars=$(pgrep polybar)
if [[ $polybars ]]; then
    # notify-send "Active polybars: $polybars"
    # echo $polybars | xargs -L1 kill &&
    for polybar in $polybars; do
        while ps -p "$polybar"; do
            kill $polybar
            sleep .2
        done
    done
fi
launch
