#!/bin/bash

if ! bluetoothctl show >/dev/null 2>&1; then
    echo '{"text":"󰂲","tooltip":"Bluetooth unavailable","class":"off"}'
    exit
fi

powered=$(bluetoothctl show | awk '/Powered:/ {print $2}')

if [ "$powered" != "yes" ]; then
    echo '{"text":"󰂲","tooltip":"Bluetooth Off","class":"off"}'
    exit
fi

device=$(bluetoothctl devices Connected | head -1 | cut -d' ' -f3-)

if [ -n "$device" ]; then
    echo "{\"text\":\"󰂯  $device\",\"tooltip\":\"Connected: $device\",\"class\":\"connected\"}"
else
    echo '{"text":"󰂯","tooltip":"Bluetooth On","class":"on"}'
fi
