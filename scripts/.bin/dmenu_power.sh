#!/bin/sh

DMENU_OPTIONS="$@"

option=$(printf "poweroff\nsuspend\nlockscreen\nreboot\nlogout" | dmenu $DMENU_OPTIONS)

confirm_action() {
    confirmation=$(printf "Yes, %s\nNo, cancel" "$1" | dmenu $DMENU_OPTIONS)
    case "$confirmation" in
        "Yes, $1")
            return 0 
            ;;
        *)
            return 1
            ;;
    esac
}

case "$option" in
    poweroff)
        if confirm_action "poweroff"; then
            systemctl poweroff
        fi
        ;;
    suspend)
        systemctl suspend
        ;;
    lockscreen)
        slock
        ;;
    reboot)
        if confirm_action "reboot"; then
            systemctl reboot
        fi
        ;;
    logout)
        if confirm_action "logout"; then
            loginctl terminate-session "${XDG_SESSION_ID-}"
        fi
        ;;
esac
