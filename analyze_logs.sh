#!/bin/bash

LOG_DIR="hospital_data/active_logs"
REPORT_FILE="reports/analysis_report.txt"

echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"
read -p "Enter choice (1-3): " choice

case $choice in
  1)
    logfile="$LOG_DIR/heart_rate.log"
    ;;
  2)
    logfile="$LOG_DIR/temperature.log"
    ;;
  3)
    logfile="$LOG_DIR/water_usage.log"
    ;;
  *)
    echo "Invalid option."
    exit 1
    ;;
esac

if [ ! -f "$logfile" ]; then
  echo "Log file does not exist."
  exit 1
fi

echo "==== Analysis on $(date) ====" >> "$REPORT_FILE"
awk '{print $1}' "$logfile" | sort | uniq -c >> "$REPORT_FILE"
first=$(head -n 1 "$logfile" | awk '{print $2 " " $3}')
last=$(tail -n 1 "$logfile" | awk '{print $2 " " $3}')
echo "First entry: $first" >> "$REPORT_FILE"
echo "Last entry: $last" >> "$REPORT_FILE"
echo "-----------------------------" >> "$REPORT_FILE"

echo "Analysis complete. Check reports/analysis_report.txt"
