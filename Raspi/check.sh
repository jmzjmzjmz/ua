#!/bin/sh
if ps -ef | grep -v grep | grep UDPlisten.py ; then
        echo "UDP already running"
        exit 0
else
        sudo python /home/pi/UDPlisten.py &
        echo "UDP not running. Launching..."
        exit 0
fi

