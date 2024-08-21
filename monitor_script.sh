#!/bin/bash

# Function to display top 10 applications consuming the most CPU and memory
top_apps() {
    echo "Top 10 CPU and Memory consuming applications:"
    ps aux --sort=-%cpu | head -n 11
    echo ""
}

# Function for network monitoring
network_monitor() {
    echo "Network Monitoring:"
    echo "Concurrent connections:"
    netstat -an | grep ESTABLISHED | wc -l
    echo "Packet drops:"
    netstat -i | awk '{print $1, $4, $5}' | column -t
    echo ""
}

# Function to display disk usage
disk_usage() {
    echo "Disk Usage:"
    df -h | awk '$5 >= 80 {print $0}'
    echo ""
}

# Function to show system load
system_load() {
    echo "System Load:"
    uptime
    mpstat
    echo ""
}

# Function to display memory usage
memory_usage() {
    echo "Memory Usage:"
    free -h
    echo ""
}

# Function to display process monitoring
process_monitoring() {
    echo "Process Monitoring:"
    ps -e --no-headers | wc -l
    ps aux --sort=-%mem | head -n 6
    echo ""
}

# Function to monitor essential services
service_monitoring() {
    echo "Service Monitoring:"
    services=("sshd" "nginx" "iptables")
    for service in "${services[@]}"; do
        systemctl is-active --quiet $service && echo "$service is running" || echo "$service is not running"
    done
    echo ""
}

# Main function to handle command-line arguments
while getopts "anmlpsd" option; do
    case $option in
        a) top_apps ;;
        n) network_monitor ;;
        d) disk_usage ;;
        l) system_load ;;
        m) memory_usage ;;
        p) process_monitoring ;;
        s) service_monitoring ;;
        *) echo "Invalid option"; exit 1 ;;
    esac
done

