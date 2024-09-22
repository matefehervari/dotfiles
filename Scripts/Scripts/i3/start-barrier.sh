#!/bin/bash

killall -o 5s barrierc
barrierc -f -n mLaptop --disable-crypto --restart $BARRIER_SERVER && barrierFixKB
