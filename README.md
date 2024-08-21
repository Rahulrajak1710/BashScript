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





# Linux Security Hardening Script

## Overview

This script automates the security audit and hardening process for Linux servers. It includes checks for user and group audits, file and directory permissions, services, firewall, network configurations, security updates, log monitoring, and server hardening. The script is designed to be reusable and modular, allowing it to be easily deployed across multiple servers.

## Features

- **User and Group Audits**
  - List all users and groups on the server.
  - Check for root users and report non-standard users.
  - Identify and report users without passwords or with weak passwords.

- **File and Directory Permissions**
  - Scan for world-writable files and directories.
  - Check permissions for SSH directories.
  - Report files with SUID or SGID bits set.

- **Service Audits**
  - List all running services.
  - Ensure critical services (e.g., `sshd`) are running and properly configured.
  - Check for services listening on non-standard or insecure ports.

- **Firewall and Network Security**
  - Verify that a firewall is active and configured.
  - Report open ports and associated services.
  - Check for IP forwarding or other insecure network configurations.

- **IP and Network Configuration Checks**
  - Identify whether IP addresses are public or private.
  - Provide a summary of IP addresses.
  - Ensure sensitive services are not exposed on public IPs unless required.

- **Security Updates and Patching**
  - Check for available security updates or patches.
  - Ensure the server is configured to receive and install security updates regularly.

- **Log Monitoring**
  - Check for recent suspicious entries indicating a security breach.

- **Server Hardening Steps**
  - **SSH Configuration**: Implement key-based authentication and disable password-based login for root.
  - **Disable IPv6**: Disable IPv6 if not in use.
  - **Secure Bootloader**: Set a password for the GRUB bootloader.
  - **Firewall Configuration**: Implement recommended `iptables` rules.
  - **Automatic Updates**: Configure unattended-upgrades for security updates.

- **Custom Security Checks**
  - The script can be extended with custom security checks via a configuration file.

- **Reporting and Alerting**
  - Generate a summary report of the security audit.
  - Optionally send email alerts if critical vulnerabilities or misconfigurations are found.

## Prerequisites

- `bash` shell
- `mail` or `mailx` command for sending emails (Install `mailutils` or `mailx` package)
- `unattended-upgrades` package (for automatic updates)



