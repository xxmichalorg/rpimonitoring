#!/bin/bash

while true; do
    cpu_temp=$(</sys/class/thermal/thermal_zone0/temp)
    cpu_temp_celsius=$((cpu_temp / 1000))
    rpm=$(</sys/devices/platform/cooling_fan/hwmon/*/fan1_input)
    gpu_temp=$(vcgencmd measure_temp | grep -o '[0-9]*\.[0-9]*' | head -n1 | awk '{printf "%d", $1}')
    ram_usage=$(free -m | awk '/^Mem:/ {print $3 "/" $2 " MB"}')
    swap_usage=$(free -m | awk '/^Swap:/ {print $3 "/" $2 " MB"}')
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1 "%"}')
    clear
    echo "=== System Monitoring ==="
    echo "CPU Temperature: $cpu_temp_celsius'C"
    echo "GPU Temperature: $gpu_temp'C"
    echo "Fan Speed: $rpm RPM"
    echo "RAM Usage: $ram_usage"
    echo "Swap Usage: $swap_usage"
    echo "========================"
    
    sleep 0.7
done
