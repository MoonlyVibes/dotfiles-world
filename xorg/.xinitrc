#!/bin/sh

# source important things
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
numlockx &
sxhkd &
nm-applet &
udiskie &
copyq &
# xss-lock --ignore-sleep -- slock & #Gets triggered on standby autolock :(
# xautolock -time 20 -locker "systemctl suspend" -detectsleep &
~/.bin/ArchPackages.sh &
exec qtile start
