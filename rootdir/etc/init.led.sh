#!/system/bin/sh

# prevent boot led from overriding charging led
if [ `cat /sys/class/sec/led/led_pattern` = "6" ]; then
    echo 0 > /sys/class/sec/led/led_pattern
fi

# remove radio snapshot files
rm /data/RS*.log
