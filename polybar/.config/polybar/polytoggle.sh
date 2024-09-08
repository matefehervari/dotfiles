# #!/bin/bash
#
# POLYSTATE=1
#
# # other_count=$(pgrep -l polylaunch.sh | wc -l)
# # if [[ $other_count != 2 ]]; then
# #   exit 0
# # fi
#
# launch ()
# {
#   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#     MONITOR=$m polybar --config="/home/mate/.config/polybar/config.ini" -r \
#       bar 2>&1 | tee -a /tmp/polybar1.log & 
#     echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
#   done
# }
#
# toggle ()
# {
#   echo "toggled"
#   if [[ $POLYSTATE == 1 ]]; then
#     polybar-msg cmd toggle
#     POLYSTATE=0
#   elif [[ $POLYSTATE == 0 ]]; then
#     polybar-msg cmd toggle
#     POLYSTATE=1
#   fi
#   return
# }
#
# # other_poly=$(pgrep polybar)
# # echo "Found running polybar instance: $other_poly"
# # if [[ -z "$other_poly" ]]; then
# #   launch
# # fi
#
# trap toggle SIGUSR1
#
# launch
# while [[ true ]]; do
#   sleep infinity &
#   pid=$!
#   wait $pid
#   kill $pid
# done
