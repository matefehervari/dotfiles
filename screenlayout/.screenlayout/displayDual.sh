#!/bin/sh

screenlayout_dir=$(dirname $(realpath $0))
current_config=$(cat $screenlayout_dir/dualConfig)

case $current_config in
  left)
    eval $screenlayout_dir/extendLeftAztine
    ;;

  above)
    eval $screenlayout_dir/extendAboveHdmi
    ;;

  *)
    notify-send "Display dual: Option not found"
    ;;
esac

if [ $? != 0 ]; then
  notify-send "Display dual: failed"
  exit
fi

eval $screenlayout_dir/displayConfig.sh
