#!/bin/bash

NETWORK_TOGGLE_STATE=hostname

log()
{
  # make dir if not exists
  [ -d /tmp/polybar ] || mkdir /tmp/polybar
  echo "$(date '+%x %X'): $1" >> /tmp/polybar/network.log
}

signal_icon()
{
  local signal_strength=$(awk "NR==3 {print \$3}" /proc/net/wireless | grep -Po "\d+")
  if [[ $signal_strength -lt 20 ]]; then
    echo "󰤯"
  elif [[ $signal_strength -lt 40 ]]; then
    echo "󰤟"
  elif [[ $signal_strength -lt 60 ]]; then
    echo "󰤢"
  elif [[ $signal_strength -lt 80 ]]; then
    echo "󰤥"
  else
    echo "󰤨"
  fi
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
  local interface=$(ip route show default | grep -Po "dev \K\S+" | head -n 1)
  if [[ $interface ]]; then
    local interface_up=$(ifconfig "$interface" | grep -o UP)
    local interface_wired=$(iwconfig "$interface" 2>&1 | grep "no wireless extensions")
  fi

  if [[ $NETWORK_TOGGLE_STATE == "hostname" ]]
  then
    log "network-toggle: Displaying hostname"
    if [[ $interface_wired ]]; then
      echo "󰛳 Wired"
    else
      echo "$(signal_icon) $(iwgetid -r)"
    fi
  elif [[ $NETWORK_TOGGLE_STATE == "ip" ]]
  then
    log "network-toggle: Displaying ip"
    ip=$(ifconfig "$interface" | grep -Po "inet \K\S+")
    echo "$(signal_icon) $ip"
  fi
}

connected() {
  [[ ! -z $interface_up && ( ! -z $interface_wired || ! -z $(iwgetid -r)) ]] 
}

process_conn_change ()
{
  local interface=$(ip route show default | grep -Po "dev \K\S+" | head -n 1)
  if [[ $interface ]]; then
    local interface_up=$(ifconfig "$interface" | grep -o UP)
    local interface_wired=$(iwconfig "$interface" 2>&1 | grep "no wireless extensions")
  fi

  if connected; then
    log "network-toggle: Connection connected"
    print_network_state
  else
    log "network-toggle: Connection not connected"
    echo "Not Connected"
  fi
}

trap toggle SIGUSR1
trap process_conn_change SIGUSR2

process_conn_change

# create process to wait for
sleep infinity &
pid=$!

while [[ 1 ]]; do
  wait $pid # will be interrupted by trap
done
