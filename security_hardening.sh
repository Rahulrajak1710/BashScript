#!/bin/bash

# Configuration
LOG_FILE="/var/log/security_hardening.log"
MAIL_TO="rahulrajak1710@gmail.com"

# Functions
log() {
    echo "$(date) - $1" | tee -a $LOG_FILE
}

run_check() {
    log "Running: $1"
    eval "$1" 2>&1 | tee -a $LOG_FILE
}

# User and Group Audits
audit_users_and_groups() {
    log "Auditing users and groups"

    # List all users and groups
    run_check "cut -d: -f1 /etc/passwd"
    run_check "cut -d: -f1 /etc/group"

    # Check for root users
    run_check "awk -F: '\$3 == 0 {print \$1}' /etc/passwd"

    # Check for users without passwords
    run_check "awk -F: '(\$2 == \"\" || length(\$2) < 8) {print \$1}' /etc/shadow"
}

# File and Directory Permissions
check_permissions() {
    log "Checking file and directory permissions"

    # Scan for world-writable files and directories
    run_check "find / -perm -002 -type f -o -type d"

    # Check SSH directories permissions
    run_check "find /etc/ssh -type d -exec ls -ld {} \;"

    # Report files with SUID or SGID bits set
    run_check "find / -perm /6000 -type f"
}

# Service Audits
audit_services() {
    log "Auditing services"

    # List all running services
    run_check "systemctl list-units --type=service --state=running"

    # Check for critical services
    run_check "systemctl status sshd"

    # Check for non-standard or insecure ports
    run_check "netstat -tuln"
}

# Firewall and Network Security
check_firewall() {
    log "Checking firewall and network security"

    # Check if firewall is active
    run_check "ufw status verbose || iptables -L -n"

    # Report open ports
    run_check "netstat -tuln"

    # Check for IP forwarding
    run_check "sysctl net.ipv4.ip_forward"
}

# IP and Network Configuration Checks
check_ip_configuration() {
    log "Checking IP configuration"

    # List IP addresses
    run_check "hostname -I"

    # Check for sensitive services on public IPs
    run_check "netstat -tuln"
}

# Security Updates and Patching
check_updates() {
    log "Checking for security updates"

    # Check for available updates
    run_check "apt-get update && apt-get -s upgrade"

    # Ensure unattended-upgrades is installed
    run_check "dpkg -l | grep unattended-upgrades"
}

# Log Monitoring
monitor_logs() {
    log "Monitoring logs"

    # Check for failed login attempts
    run_check "grep 'Failed password' /var/log/auth.log"
}

# Server Hardening Steps
harden_server() {
    log "Hardening server"

    # SSH Configuration
    run_check "sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config"
    run_check "systemctl restart sshd"

    # Disable IPv6
    run_check "sysctl -w net.ipv6.conf.all.disable_ipv6=1"
    run_check "sysctl -w net.ipv6.conf.default.disable_ipv6=1"

    # Secure bootloader (GRUB)
    run_check "echo 'GRUB_PASSWORD=admin@123' >> /etc/default/grub"
    run_check "grub2-mkpasswd-pbkdf2 | tee -a /etc/default/grub"
    run_check "grub2-mkconfig -o /boot/grub2/grub.cfg"
    
    # Configure firewall
    run_check "iptables -P INPUT DROP"
    run_check "iptables -P FORWARD DROP"
    run_check "iptables -P OUTPUT ACCEPT"
    run_check "iptables -A INPUT -i lo -j ACCEPT"
    run_check "iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT"

    # Automatic Updates
    run_check "apt-get install -y unattended-upgrades"
}

# Reporting and Alerting
report_and_alert() {
    log "Generating security report"
    
    # Generate report
    cat $LOG_FILE | mail -s "Security Hardening Report" $MAIL_TO
}

# Main
main() {
    audit_users_and_groups
    check_permissions
    audit_services
    check_firewall
    check_ip_configuration
    check_updates
    monitor_logs
    harden_server
    report_and_alert
}

main

