#!/bin/bash

# Log messages
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$REPORT_FILE"
}

# User and Group Audits
log "User and Group Audits"
run_and_log "cat /etc/passwd" "Listing all users and groups"
run_and_log "cat /etc/group" "Listing all groups"
run_and_log "awk -F: '$3 == 0 {print \$1}' /etc/passwd" "Users with UID 0 (root privileges)"
run_and_log "grep -E '^[^:]+:[^:]*$' /etc/shadow" "Users without passwords"
run_and_log "find / -perm -04000 -type f" "Files with SUID bits set"
run_and_log "find / -perm -02000 -type f" "Files with SGID bits set"


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
