#!/bin/bash

# Configuration
LOG_DIR="active_logs"
REPORT_DIR="hospital_data/reports"
REPORT_FILE="$REPORT_DIR/analysis_report.txt"

# Function to display menu and get user choice
show_menu() {
    echo "Select log file to analyze:"
    echo "1) Heart Rate (heart_rate_log.log)"
    echo "2) Temperature (temperature_log.log)"
    echo "3) Water Usage (water_usage_log.log)"
    echo -n "Enter choice (1-3): "
}

# Function to validate input
validate_input() {
    if [[ "$1" =~ ^[1-3]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to ensure reports directory exists
ensure_reports_dir() {
    if [ ! -d "$REPORT_DIR" ]; then
        echo "Creating reports directory: $REPORT_DIR"
        mkdir -p "$REPORT_DIR"
        if [ $? -ne 0 ]; then
            echo "Error: Could not create reports directory"
            exit 1
        fi
    fi
}

# Function to analyze log file
analyze_log() {
    local choice="$1"
    local logfile=""
    local log_type=""
    
    # Determine log file based on choice
    case "$choice" in
        1)
            logfile="$LOG_DIR/heart_rate_log.log"
            log_type="Heart Rate"
            ;;
        2)
            logfile="$LOG_DIR/temperature_log.log"
            log_type="Temperature"
            ;;
        3)
            logfile="$LOG_DIR/water_usage_log.log"
            log_type="Water Usage"
            ;;
    esac
    
    # Check if log file exists
    if [ ! -f "$logfile" ]; then
        echo "Error: Log file $logfile does not exist!"
        exit 1
    fi
    
    # Check if log file is empty
    if [ ! -s "$logfile" ]; then
        echo "Warning: Log file $logfile is empty!"
        return
    fi
    
    echo "Analyzing $log_type log..."
    
    # Ensure reports directory exists
    ensure_reports_dir
    
    # Write analysis header
    {
        echo "=================================="
        echo "Analysis Report - $(date)"
        echo "Log Type: $log_type"
        echo "Log File: $logfile"
        echo "=================================="
        echo ""
    } >> "$REPORT_FILE"
    
    # Device count analysis
    echo "Device Statistics:" >> "$REPORT_FILE"
    
    # Extract device names and count occurrences
    # Assuming log format: "YYYY-MM-DD HH:MM:SS DeviceName ..."
    awk '{print $3}' "$logfile" | sort | uniq -c | while read count device; do
        echo "  $device: $count entries" >> "$REPORT_FILE"
    done
    
    echo "" >> "$REPORT_FILE"
    
    # Temporal analysis (first/last entries)
    if [ -s "$logfile" ]; then
        first_entry=$(head -n 1 "$logfile")
        last_entry=$(tail -n 1 "$logfile")
        
        first_timestamp=$(echo "$first_entry" | awk '{print $1 " " $2}')
        last_timestamp=$(echo "$last_entry" | awk '{print $1 " " $2}')
        
        {
            echo "Temporal Analysis:"
            echo "  First Entry: $first_timestamp"
            echo "  Last Entry: $last_timestamp"
            echo ""
            echo "Sample Entries:"
            echo "  First: $first_entry"
            echo "  Last: $last_entry"
            echo ""
        } >> "$REPORT_FILE"
    fi
    
    # Add separator
    echo "-----------------------------" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    echo "Analysis complete! Results appended to $REPORT_FILE"
}

# Main function
main() {
    show_menu
    read -r choice
    
    if validate_input "$choice"; then
        analyze_log "$choice"
    else
        echo "Error: Invalid choice. Please enter 1, 2, or 3."
        exit 1
    fi
}

# Execute main function
main

