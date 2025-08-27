#!/bin/bash

# while getopts "m:" flag
# do
#     case "$flag" in
#         m)
#             num_mon=$OPTARG
#         ;;
#     esac
# done
#
# function num_mons {
#     xrandr --listactivemonitors | tail -n +2 | wc -l
# }
logger "Running polylaunch"

launch ()
{
    # if [[ $num_mon ]]; then
    #     while [[ $num_mon != $(num_mons) ]]; do
    #         notify-send "num mon not equal to $num_mon"
    #         sleep .5
    #     done
    #     notify-send "num mon equal to $num_mon"
    # fi

    monitors=$(xrandr | grep -Po "^\S+ connected" | cut -d " " -f 1)
    logger "Launching polybars for monitors: $monitors"
    logger "DISPLAY=$DISPLAY"
    logger "XAUTHORITY=$XAUTHORITY"
    command -v polybar | logger
    primary=$(xrandr | grep -P "primary" | cut -d " " -f 1)
    for monitor in $monitors; do
        logger "Launching poybar for monitor: $monitor"
        if [[ $monitor == "DP-1-1" ]]; then
            continue
        fi
        if [[ $monitor == $primary ]]; then
            logger "Configuring primary"
            # MONITOR=$monitor polybar --config="/home/mate/.config/polybar/config.ini" -r \
            #   primary 2>&1 | tee -a /tmp/polybar1.log & 
            logger "Polybars before: $(pgrep polybar)"
            MONITOR=$monitor setsid polybar --config="/home/mate/.config/polybar/config.ini" -r \
              primary >> /tmp/polybar1.log 2>&1 & 
            logger "Polybars after: $(pgrep polybar)"
        else
          logger "Configuring non-primary"
          logger "Polybars before: $(pgrep polybar)"
          MONITOR=$monitor setsid polybar --config="/home/mate/.config/polybar/config.ini" -r \
              secondary >> /tmp/polybar1.log 2>&1 &
          logger "Polybars after: $(pgrep polybar)"
        fi
    done
}

# polybars=$(pgrep polybar)
# logger "Polybars to kill: $polybars"
# if [[ $polybars ]]; then
#     # notify-send "Active polybars: $polybars"
#     # echo $polybars | xargs -L1 kill &&
#     for polybar in $polybars; do
#         while kill -0 "$polybar" 2>/dev/null; do
#             kill $polybar 2>/dev/null
#             sleep .2
#         done
#     done
# fi
# logger "killed polybars"
launch
logger "launched"
