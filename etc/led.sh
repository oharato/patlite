#!/bin/sh
echo "14" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio14/direction

while true
do
	echo "1" > /sys/class/gpio/gpio14/value
	sleep 0.1
        echo "0" > /sys/class/gpio/gpio14/value
        sleep 0.1
done
