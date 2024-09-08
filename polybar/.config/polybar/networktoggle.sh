#!/bin/bash

NETWORK_TOGGLE_STATE=hostname

log()
{
  echo "$(date '+%x %X'): $1" >> /tmp/polybar/network.log
}

toggle ()
{
  if [[ -z "$(iwgetid -r)" ]]
  then
    return
  fi

  if [[ $NETWORK_TOGGLE_STATE == "hostname" ]]
  then
    NETWORK_TOGGLE_STATE=ip
  elif [[ $NETWORK_TOGGLE_STATE == "ip" ]]
  then
    NETWORK_TOGGLE_STATE=hostname
  fi
  print_network_state
}

print_network_state ()
{
  if [[ $NETWORK_TOGGLE_STATE == "hostname" ]]
  then
    log "network-toggle: Displaying hostname"
    echo "$(iwgetid -r)"
  elif [[ $NETWORK_TOGGLE_STATE == "ip" ]]
  then
    log "network-toggle: Displaying ip"
    echo "$(hostname -I | cut -d' ' -f1)"
  fi
}

process_conn_change ()
{
  if [[ -z "$(iwgetid -r)" ]]; then
    log "network-toggle: Connection not connected"
    echo "Not Connected"
  else
    log "network-toggle: Connection connected"
    print_network_state
  fi
}

trap toggle SIGUSR1
trap process_conn_change SIGUSR2

process_conn_change
while [[ 1 ]]; do
  sleep infinity &
  pid=$!
  wait $pid
  kill $pid
done
