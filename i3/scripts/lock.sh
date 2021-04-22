#!/bin/bash
#
# This will pause dunst when the screen's locked to prevent notifications from
# popping up on top of the lock screen
#
# Example configuration (~/.i3/config):
# bindsym $mod+l exec ~/.i3/scripts/lock.sh

pkill -u "$USER" -USR1 dunst
xset dpms force off
i3lock -c 000000 -n
pkill -u "$USER" -USR2 dunst

