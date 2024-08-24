#!/bin/bash

# Log messages
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$REPORT_FILE"
}

# User and Group Audits
{
    echo "User and Group Audits"
    echo "List of Users and Groups"
    cut -d: -f1 /etc/passwd
    cut -d: -f1 /etc/group
    echo
    echo "Users with UID 0 (Root Privileges)"
    awk -F: '$3 == 0 {print $1}' /etc/passwd
    echo
    echo "Users Without Passwords or with Weak Passwords"
    awk -F: '($2 == "" || $2 == "x") {print $1}' /etc/shadow
    echo
} >> "$REPORT_FILE"


# File and Directory Permissions
{
    echo "File and Directory Permissions"
    echo "World-Writable Files and Directories"
    find / -perm -0002 -type f -o -type d 2>/dev/null
    echo
    echo ".ssh Directory Permissions"
    find /home -name ".ssh" -type d -exec ls -ld {} \; 2>/dev/null
    echo
    echo "Files with SUID or SGID Bits Set"
    find / -perm -4000 -o -perm -2000 -type f 2>/dev/null
    echo
} >> "$REPORT_FILE"


# Service Audits
{
    echo "Service Audits"
    echo "List of Running Services"
    systemctl list-units --type=service --state=running
    echo
    echo "Critical Services Status"
    for service in sshd iptables; do
        systemctl is-active --quiet "$service" && echo "$service is running." || echo "$service is not running."
    done
    echo
    echo "Services Listening on Ports"
    netstat -tuln
    echo
} >> "$REPORT_FILE"


# Firewall and Network Security
{
    echo "Firewall and Network Security"
    echo "Firewall Status"
    if command -v ufw >/dev/null 2>&1; then
        ufw status verbose
    elif command -v iptables >/dev/null 2>&1; then
        iptables -L -v -n
    else
        echo "No firewall detected."
    fi
    echo
    echo "Open Ports"
    ss -tuln
    echo
    echo "IP Forwarding Configuration"
    sysctl net.ipv4.ip_forward
    sysctl net.ipv6.conf.all.forwarding
    echo
} >> "$REPORT_FILE"


# IP and Network Configuration Checks
{
    echo "IP and Network Configuration Checks"
    echo "List of IP Addresses"
    ip -o addr show | awk '{print $2, $4}'
    echo
    echo "IP Address Classification (Public/Private)"
    # Placeholder for actual IP classification logic
    echo "Public vs. Private IP classification not implemented."
    echo
} >> "$REPORT_FILE"


# Security Updates and Patching
{
    echo "Security Updates and Patching"
    echo "Available Security Updates"
    if command -v apt-get >/dev/null 2>&1; then
        apt-get update -y
        apt-get upgrade -s
    elif command -v yum >/dev/null 2>&1; then
        yum check-update
    else
        echo "No package manager detected."
    fi
    echo
} >> "$REPORT_FILE"


# Log Monitoring
{
    echo "Log Monitoring"
    echo "Recent Suspicious SSH Log Entries"
    grep "Failed password" /var/log/auth.log | tail -n 50
    echo
} >> "$REPORT_FILE"


# Server Hardening Steps
{
    echo "Server Hardening Steps"
    echo "SSH Configuration"
    echo "Disabling root password authentication..."
    sed -i 's/^#\?PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
    echo "Implementing SSH key-based authentication"
    echo "Ensure authorized_keys are securely stored."
    echo
    echo "IPv6 Configuration"
    if [ "$DISABLE_IPV6" == "true" ]; then
        sysctl -w net.ipv6.conf.all.disable_ipv6=1
        sysctl -w net.ipv6.conf.default.disable_ipv6=1
        sysctl -w net.ipv6.conf.lo.disable_ipv6=1
        echo "IPv6 has been disabled."
    else
        echo "IPv6 disabling is not configured."
    fi
    echo
    echo "Securing the Bootloader"
    echo "Please set a GRUB password manually using the command:"
    echo "  grub2-set-password -p PASSWORD"
    echo
    echo "Firewall Configuration"
    # Placeholder for iptables rules
    echo "Implement iptables rules as per security policy."
    echo
    echo "Automatic Updates"
    if command -v apt-get >/dev/null 2>&1; then
        apt-get install unattended-upgrades -y
        dpkg-reconfigure --priority=low unattended-upgrades
    else
        echo "Automatic updates not configured for non-apt systems."
    fi
    echo
} >> "$REPORT_FILE"


# Custom Security Checks
{
    echo "Custom Security Checks"
    # Example: source $CUSTOM_SECURITY_CHECKS_SCRIPT
    echo "Custom security checks not implemented."
    echo
} >> "$REPORT_FILE"
