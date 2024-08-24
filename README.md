# DevOps-Test

# Custom Dashboard Script

This script provides a real-time dashboard for monitoring various system resources on your server. It can display information on CPU usage, memory usage, network statistics, disk usage, process details, and service statuses.

## Features

- Top 10 Most Used Applications : Display the applications 10 most CPU and memory.
- Network Monitoring : Displays network traffic, concurrent connections, and packet drops.
- Disk Usage : Display disk space usage and highlights partitions using more than 80% of their space.
- System Load : Provides load averages and CPU usage breakdown.
- Memory Usage : Displays total, used, and free memory, along with swap memory usage.
- Process Monitoring : Display the number of active processes and the top 5 processes by CPU and memory usage.
- Service Monitoring : Monitors the status of essential services.

## Prerequisites

Following tools are installed on your system:
- `ps`
- `netstat`
- `df`
- `uptime`
- `free`
- `mpstat`
- `systemctl`
- `awk`
- `bc` (for calculating network traffic in MB)


########### Monitoring System Resources for a Proxy Server ###########

# Explanation:

# Configuration Handling:

The script uses a configuration file security_config.conf for settings like disabling IPv6 and custom security checks. Ensure this file exists or modify the script as needed.

## User and Group Audits:
 -Lists all users and groups.
 -Checks for UID 0 users and users with no passwords.

## File and Directory Permissions:
 -Identifies world-writable files and directories.
 -Ensures .ssh directories have secure permissions.
 -Reports SUID and SGID bits.

## Service Audits:
 -Lists running services.
 -Checks critical services like sshd and iptables.
 -Checks for non-standard open ports.

## Firewall and Network Security:
 -Verifies firewall status (UFW or iptables).
 -Lists open ports and checks IP forwarding.

## IP and Network Configuration Checks:
 -Lists IP addresses and identifies if they are public or private.

## Security Updates and Patching:
 -Checks for available security updates.

## Log Monitoring:
 -Looks for suspicious log entries related to SSH.

## Server Hardening Steps:
 -Implements hardening measures like disabling root password authentication, securing the bootloader, and configuring automatic updates.

## Custom Security Checks:
 -Allows inclusion of custom checks based on organizational policies.

## Reporting and Alerting:
 -Generates a summary report and logs the findings.

## Usage:
 -Save the script to a file named secure-server.sh.
 -Make it executable: chmod +x secure-server.sh.
 -Run the script: sudo ./secure-server.sh.
