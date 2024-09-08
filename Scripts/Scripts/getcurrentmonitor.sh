#!/bin/sh
monitor=$(xrandr --listactivemonitors | grep -o -P "0: \K(eDP.+?) ")
echo $monitor
