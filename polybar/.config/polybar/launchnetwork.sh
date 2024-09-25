#!/bin/bash

killall -o 5s networktoggle.sh 2>/dev/null # direct error to null if no proccess found
$HOME/.config/polybar/networktoggle.sh 2>&1 | tee -a /tmp/polybar/network.log
