killall -o 5s xborders
/home/mate/util/xborder-inactive/xborders \
  -c $(dirname "$0")/config.json \
  2>&1 | tee -a /tmp/xborder.log
