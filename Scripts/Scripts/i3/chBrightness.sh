#!/bin/bash

inc=10

if [[ $1 = "inc" ]]; then
  echo "$BRIGHTNESS initial"
  let BRIGHTNESS=$BRIGHTNESS+10
  export BRIGHTNESS=$BRIGHTNESS
  echo $BRIGHTNESS
  brightnessctl set "$BRIGHTNESS%"

elif [[ $1 = dec ]]; then
  let BRIGHTNESS=$BRIGHTNESS-10
  export BRIGHTNESS=$BRIGHTNESS
  echo %BRIGHTNESS
  brightnessctl set "$BRIGHTNESS%"
fi
