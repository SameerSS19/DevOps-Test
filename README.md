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
