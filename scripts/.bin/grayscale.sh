#!/bin/sh
NORMAL_PICOM="picom"
GRAYSCALE_PICOM="picom --backend glx --window-shader-fg $HOME/.config/picom/grayscale.glsl"

if pgrep -fx "$GRAYSCALE_PICOM" > /dev/null; then
    killall picom
    sleep 0.1
    $NORMAL_PICOM &
elif pgrep -x picom > /dev/null; then
    killall picom
    sleep 0.1
    $GRAYSCALE_PICOM &
else
    $NORMAL_PICOM &
fi

