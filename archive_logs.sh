#!/bin/bash

LOG_DIR="hospital_data/active_logs"
ARCHIVE_HEART="heart_data_archive"
ARCHIVE_TEMP="temperature_data_archive"
ARCHIVE_WATER="water_usage_archive"

echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

timestamp=$(date +"%Y-%m-%d_%H:%M:%S")

case $choice in
  1)
    src="$LOG_DIR/heart_rate.log"
    dest="$ARCHIVE_HEART/heart_rate_$timestamp.log"
    new="$LOG_DIR/heart_rate.log"
    ;;
  2)
    src="$LOG_DIR/temperature.log"
    dest="$ARCHIVE_TEMP/temperature_$timestamp.log"
    new="$LOG_DIR/temperature.log"
    ;;
  3)
    src="$LOG_DIR/water_usage.log"
    dest="$ARCHIVE_WATER/water_usage_$timestamp.log"
    new="$LOG_DIR/water_usage.log"
    ;;
  *)
    echo "Invalid option. Please select 1, 2, or 3."
    exit 1
    ;;
esac

if [ ! -f "$src" ]; then
  echo "Error: Log file does not exist."
  exit 1
fi

mv "$src" "$dest"
touch "$new"
echo "Archived to $dest"
