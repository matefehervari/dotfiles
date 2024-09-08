#!/bin/bash
u=$(xprop -name "polybar-tray" _NET_WM_PID | grep -o '[[:digit:]]*')

if [[ $u ]]; then
  kill $u
fi
