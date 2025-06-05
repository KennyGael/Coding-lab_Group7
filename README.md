# Hospital Data Monitoring & Archival System (Group 7)

This project simulates and manages hospital device logs using Python and shell scripts. It collects real-time data from sensors, archives logs with timestamps, and analyzes them to generate useful statistics.

---

## 🛠️ How to Run the System

### 1. Start the Simulators (in 3 separate terminals)

Open 3 terminal windows or SSH sessions. In each, run the following commands:

```bash
cd Coding-lab_Group7
python3 heart_monitor.py start

cd Coding-lab_Group7
python3 temp_sensor.py start

cd Coding-lab_Group7
python3 water_meter.py start
```

2. Archive a Log File
In a 4th terminal (or after stopping one simulator temporarily), run:

```bash
cd Coding-lab_Group7
./archive_logs.sh
```

You will be prompted to choose which log to archive.

The script will move the selected log to its archive folder and rename it with a timestamp.

A new, empty log file will be created automatically.

3. Analyze a Log File
To analyze a log and generate a report, run:

```bash
cd Coding-lab_Group7
./analyze_logs.sh
```

Select a log file (heart rate, temperature, or water usage).

The script will count occurrences per device and log timestamps.

Results are saved in: reports/analysis_report.txt

📁 Folder Structure
```bash
Coding-lab_Group7/
│
├── archive_logs.sh
├── analyze_logs.sh
├── heart_monitor.py
├── temp_sensor.py
├── water_meter.py
├── README.md
│
├── hospital_data/
│   └── active_logs/
│       ├── heart_rate.log
│       ├── temperature.log
│       └── water_usage.log
│
├── heart_data_archive/
├── temperature_data_archive/
├── water_usage_archive/
├── reports/
    └── analysis_report.txt
```

## 👥 Group Members
1. Kenny Gael ISHIMWE GATETE
2. Jesse NKUBITO
3. Nelson ISHIMWE
4. Victor Mugisha Shyaka
5. Ange MUHAWENIMANA
6. Moses MUGISHA
