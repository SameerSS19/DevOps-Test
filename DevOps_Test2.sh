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
