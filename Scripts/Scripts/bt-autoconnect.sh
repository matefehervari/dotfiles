#!/bin/bash

# sleep 10
HEADPHONE_MAC="F8:4E:17:52:FB:6D" # WHXM4
BT_KB_MAC="16:28:80:D1:AC:4A"  # ARTECK
DEVICES=($BT_KB_MAC)

powered() {
    echo "show" | bluetoothctl | grep "Powered" | cut -d " " -f 2
}

connected() {
    MAC=$1
    echo "info $MAC" | bluetoothctl | grep "Connected" | cut -d " " -f 2
}

while true
do
    sleep 1
    for MAC in ${DEVICES[@]}; do 
      connection_status=$(connected $MAC)
      if [ $(powered) = yes ] && [ $connection_status = no ]; then
          echo "[BT-Auto] Attempting to connect to $MAC..."

          echo "connect ${MAC}" | bluetoothctl

          echo "[BT-Auto] $MAC Connected: $connection_status"
          sleep 5
      fi
    done
done
