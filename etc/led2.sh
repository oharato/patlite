#!/bin/sh
echo "4" > /sys/class/gpio/export
echo "17" > /sys/class/gpio/export
echo "27" > /sys/class/gpio/export
echo "22" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio4/direction
echo "out" > /sys/class/gpio/gpio17/direction
echo "out" > /sys/class/gpio/gpio27/direction
echo "out" > /sys/class/gpio/gpio22/direction

while true
do
	echo "1" > /sys/class/gpio/gpio4/value
	sleep 0.1
        echo "0" > /sys/class/gpio/gpio4/value
        sleep 0.1
        echo "1" > /sys/class/gpio/gpio17/value
        sleep 0.1
        echo "0" > /sys/class/gpio/gpio17/value
        sleep 0.1
        echo "1" > /sys/class/gpio/gpio27/value
        sleep 0.1
        echo "0" > /sys/class/gpio/gpio27/value
        sleep 0.1
        echo "1" > /sys/class/gpio/gpio22/value
        sleep 0.1
        echo "0" > /sys/class/gpio/gpio22/value
        sleep 0.1
done
