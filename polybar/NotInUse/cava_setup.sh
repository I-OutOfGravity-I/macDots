#! /bin/bash
isrunning=false

while true; do
    if   [[ $(pactl list sink-inputs | grep 'stream.is-live = "true"') ]];
    then
        for pid in $(pidof -x "cava.sh"); do
            if [ $pid != $$ ]; then
                isrunning=true
            fi
        done
        if [ "$isrunning" = false ] ; then
            $HOME/.config/polybar/cava.sh &
        fi
	sleep 3
    else
        sleep 3
        if !  [[ $(pactl list sink-inputs | grep 'stream.is-live = "true"') ]];
        then
            echo""
            pkill "cava.sh"
            pkill "cava"
        fi
    fi
    sleep 2
done
