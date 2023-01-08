#!/bin/sh

connection_status() {
    if [ -f "$config" ]; then
        connection=$(sudo wg show "$config_name" 2>/dev/null | head -n 1 | awk '{print $NF }')
        if [ "$connection" = "$config_name" ]; then
            echo "1"
        else
            echo "2"
        fi
    else
        echo "3"
    fi
}

config="/home/OutOfGravity/.config/polybar/mullvad-de10.conf"
config_name=$(basename "${config%.*}")
#echo $config
#echo $config_name

case "$1" in
    --toggle)
        if [ "$(connection_status)" = "1" ]; then
            sudo wg-quick down "$config" 2>/dev/null
            echo 
        else
            sudo wg-quick up "$config" 2>/dev/null
            echo 
        fi
    ;;
    *)
        if [ -f "$config" ]; then
            connection=$(sudo wg show "$config_name" 2>/dev/null | head -n 1 | awk '{print $NF }')
            if [ "$connection" = "$config_name" ]; then
                echo 
            else
                echo 
            fi
        else
            echo "#3 Config not found!"
        fi
    ;;
esac

