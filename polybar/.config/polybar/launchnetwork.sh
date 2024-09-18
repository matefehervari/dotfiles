#!/bin/bash

killall -p networktoggle.sh
$HOME/.config/polybar/networktoggle.sh 2>&1 | tee -a /tmp/polybar/network.log
