# System Monitoring Script

This script provides various system monitoring functions on a Linux server. It includes functionalities to check CPU and memory usage, network status, disk usage, system load, memory usage, process monitoring, and service statuses.

## Prerequisites

- A Linux server or machine
- Basic knowledge of terminal commands
- Bash shell

## Script Overview

### Functions

1. **Top Applications (`-a`)**
   - Displays the top 10 applications consuming the most CPU and memory.
   - Uses `ps aux` to list processes sorted by CPU usage.

2. **Network Monitoring (`-n`)**
   - Shows the number of concurrent connections and packet drops.
   - Uses `netstat` to count established connections and display packet drops.

3. **Disk Usage (`-d`)**
   - Lists disk partitions with usage greater than or equal to 80%.
   - Uses `df -h` to show human-readable disk usage and filters output.

4. **System Load (`-l`)**
   - Displays system load and CPU statistics.
   - Uses `uptime` to show system load and `mpstat` for CPU usage statistics.

5. **Memory Usage (`-m`)**
   - Shows memory usage in a human-readable format.
   - Uses `free -h` to display memory usage.

6. **Process Monitoring (`-p`)**
   - Displays the total number of processes and the top 5 memory-consuming processes.
   - Uses `ps -e` to count processes and `ps aux` to list top memory-consuming processes.

7. **Service Monitoring (`-s`)**
   - Checks the status of essential services (`sshd`, `nginx`, `iptables`).
   - Uses `systemctl is-active` to check if the services are running.
**Note**
- we also can use `./monitor_script.sh -a && ./monitor_script.sh -n && ./monitor_script.sh -d && ./monitor_script.sh -l && ./monitor_script.sh -m && ./monitor_script.sh -p && ./monitor_script.sh -s > output777.txt` 

## Usage

1. **Save the Script**

   Save the script to a file named `monitoring.sh`.

2. **Make the Script Executable**

   Give the script executable permissions:

   ```bash
   chmod +x monitoring.sh
