#!/bin/sh

if eww active-windows | grep -q '^media_popup:'; then
    eww close media_popup
else
    eww open media_popup --pos 215x5
fi
