#! /bin/bash
isrunning=false

while true; do
    if   [[ $(pacmd list-sink-inputs | grep "state: RUNNING") ]];
    then
        for pid in $(pidof -x "cava.sh"); do
            if [ $pid != $$ ]; then
                isrunning=true
            fi
        done
        if [ "$isrunning" = false ] ; then
            $HOME/.config/polybar/cava.sh &
        fi
    else
        sleep 2
        if !  [[ $(pacmd list-sink-inputs | grep "state: RUNNING") ]];
        then
            echo""
            pkill "cava.sh"
            pkill "cava"
        fi
    fi
    sleep 1
done
