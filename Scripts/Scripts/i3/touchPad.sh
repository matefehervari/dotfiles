#!/bin/sh

devID=$(xinput | grep Touchpad | grep -P '(?<=id=)\d+' -o)
propsEnable="libinput Tapping Enabled,libinput Natural Scrolling Enabled"
IFS=,
for prop in $propsEnable
do
  xinput set-prop $devID $prop 1
done
