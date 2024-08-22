#!/bin/bash

# Display top 10 most used applications
display_top_apps() {
  echo -e "Most Used 10 Applications(CPU):"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 11
  echo "Most used 10 Applications(Memory)"
  ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 11
}


# Display network monitoring
display_network() {
  echo -e "Network Monitoring:"
# Concurrent Connections
  echo -e "Number of Concurrent Connections:"
# Replace '80' with the port number you want to monitor
  ss -s | grep 'ESTAB' | awk '{print $2 " ESTABLISHED connections"}'
# Packet Drops
  echo -e "Packet Drops:"
# Replace 'eth0' with your actual network interface if different
  netstat -i | awk '/^eth0/ {print "Received: " $3 " Transmitted: " $7 " (Packets)"}'
  echo -e "nNumber of MB In and Out:"
  vnstat --oneline | awk -F';' '{print "In: " $10 " Out: " $12}'
}


# Display disk usage
display_disk_usage() {
  echo -e "Disk Usage by Mounted Partitions:"
  df -h | awk '$5 > 80 {print "WARNING: " $0} $5 <= 80 {print $0}'
}


# Display system load
display_system_load() {
  echo -e "System Load Average:"
  uptime | awk -F'load average' '{print $2}'
  echo -e "CPU Usage Breakdown:"
  mpstat
}

# Display memory usage
display_memory_usage() {
  echo -e "Memory Usage:"
  free -h
  echo -e "Swap Memory Usage:"
  swapon --show
}

# Display process monitoring
display_process_monitoring() {
  echo -e "Number of Active Processes:"
  ps aux | wc -l
  echo -e "Top 5 Processes by CPU Usage:"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
  echo -e "Top 5 Processes by Memory Usage:"
  ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
}



# Display service status
display_service_status() {
  echo -e "Service Status:"
  for service in sshd nginx apache2 iptables; do
    echo -n "$service: "
    systemctl is-active --quiet $service && echo "Active" || echo "Inactive"
  done
}
