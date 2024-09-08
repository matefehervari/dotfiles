#!/bin/bash

killall -p barrierc
sleep .5
barrierc -f -n mLaptop --disable-crypto --restart $BARRIER_SERVER
sleep .5
barrierFixKB
