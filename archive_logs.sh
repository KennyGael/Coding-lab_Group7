#!/bin/bash

# Function to display menu and get user choice
show_menu() {
    echo "Select log to archive:"
    echo "1) Heart Rate"
    echo "2) Temperature"
    echo "3) Water Usage"
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

# Function to archive log file
archive_log() {
    local log_type="$1"
    local source_file=""
    local archive_dir=""
    local log_name=""
    
    case "$log_type" in
        1)
            source_file="active_logs/heart_rate_log.log"
            archive_dir="hospital_data/archived_logs/heart_data_archive"
            log_name="heart_rate"
            ;;
        2)
            source_file="active_logs/temperature_log.log"
            archive_dir="hospital_data/archived_logs/temperature_archive"
            log_name="temperature"
            ;;
        3)
            source_file="active_logs/water_usage_log.log"
            archive_dir="hospital_data/archived_logs/water_usage_archive"
            log_name="water_usage"
            ;;
    esac
    
    # Check if source file exists
    if [ ! -f "$source_file" ]; then
        echo "Error: Log file $source_file not found!"
        exit 1
    fi
    
    # Check if archive directory exists
    if [ ! -d "$archive_dir" ]; then
        echo "Error: Archive directory $archive_dir not found!"
        exit 1
    fi
    
    # Generate timestamp
    timestamp=$(date +"%Y-%m-%d_%H:%M:%S")
    archive_filename="${log_name}_${timestamp}.log"
    archive_path="${archive_dir}/${archive_filename}"
    
    # Archive the file
    echo "Archiving ${log_name}.log..."
    if mv "$source_file" "$archive_path"; then
        echo "Successfully archived to $archive_path"
        
        # Create new empty log file
        if touch "$source_file"; then
            echo "Created new empty log file: $source_file"
        else
            echo "Warning: Could not create new log file"
            exit 1
        fi
    else
        echo "Error: Failed to archive log file"
        exit 1
    fi
}

# Main function to execute all funcitons
main() {
    show_menu
    read -r choice
    
    if validate_input "$choice"; then
        archive_log "$choice"
    else
        echo "Error: Invalid choice. Please enter 1, 2, or 3."
        exit 1
    fi
}

main
