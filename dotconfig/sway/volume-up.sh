#!/bin/bash
max_volume_pc=$1
current_volume_pc=$(pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
if (($current_volume_pc < $max_volume_pc-5)) ; then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
else
    a=$(($max_volume_pc - $current_volume_pc))
    pactl set-sink-volume @DEFAULT_SINK@ +$a%
fi
