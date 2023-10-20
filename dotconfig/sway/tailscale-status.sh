#!/bin/bash

ts_status=$(tailscale status)
if [ "$ts_status" == "Tailscale is stopped." ]
then echo "down"
else echo "up"
fi
