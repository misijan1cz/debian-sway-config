#!/bin/bash
radio=$1
wifi_state=$(nmcli r | tail -n 1 | cut -d' ' -f 3 | cut -c1)
bt_state=$(bluetoothctl show | grep 'PowerState' | cut -d' ' -f2)

if [[ "$radio" = "wifi" ]]; then
  if [[ "$wifi_state" = "d" ]]; then
      nmcli r all on
  else
      nmcli r all off
  fi;
else
  if [[ "$bt_state" = "off" ]]; then
      bluetoothctl power on
  else
      bluetoothctl power off
  fi;
fi
