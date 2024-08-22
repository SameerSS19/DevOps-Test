#!/bin/bash

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
  echo -e "\nNumber of MB In and Out:"
  vnstat --oneline | awk -F';' '{print "In: " $10 " Out: " $12}'
}

