#!/bin/bash

# Display top 10 most used applications
display_top_apps() {
  echo -e "Most Used 10 Applications(CPU):"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 11
  echo "Most used 10 Applications(Memory)"
  ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 11
}
