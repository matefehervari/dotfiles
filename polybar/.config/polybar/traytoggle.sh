#!/bin/bash

echo "---" | tee -a /tmp/polybar2.log
# polybar bar 2>&1 # >> /tmp/polybar2.log 2>&1
u=$(xprop -name "polybar-tray" _NET_WM_PID | grep -o '[[:digit:]]*')
if [[ -z $u ]]
then
  polybar -r tray 2>&1 >> /tmp/polybar2.log 2>&1
else
  kill $u
fi
