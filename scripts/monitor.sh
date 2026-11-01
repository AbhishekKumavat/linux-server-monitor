
#!/bin/bash

# Linux Server Health Monitoring System

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR" || exit 1

# Load configuration
source "$PROJECT_DIR/config/config.conf"

# Create log directory if missing
mkdir -p logs

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# CPU MONITORING
read cpu user nice system idle iowait irq softirq steal rest < /proc/stat

CPU_IDLE_1=$((idle + iowait))
CPU_TOTAL_1=$((user + nice + system + idle + iowait + irq + softirq + steal))

sleep 1

read cpu user nice system idle iowait irq softirq steal rest < /proc/stat

CPU_IDLE_2=$((idle + iowait))
CPU_TOTAL_2=$((user + nice + system + idle + iowait + irq + softirq + steal))

TOTAL_DIFF=$((CPU_TOTAL_2 - CPU_TOTAL_1))
IDLE_DIFF=$((CPU_IDLE_2 - CPU_IDLE_1))

if [ "$TOTAL_DIFF" -gt 0 ]; then
    CPU_USAGE=$((100 * (TOTAL_DIFF - IDLE_DIFF) / TOTAL_DIFF))
else
    CPU_USAGE=0
fi

# RAM MONITORING
RAM_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

# DISK MONITORING
DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

# SYSTEM INFORMATION
UPTIME=$(uptime -p)
PROCESS_COUNT=$(ps -e --no-headers | wc -l)

# DISPLAY REPORT
echo "======================================"
echo "       LINUX SERVER HEALTH REPORT"
echo "======================================"

echo "Date       : $TIMESTAMP"
echo "CPU Usage  : $CPU_USAGE%"
echo "RAM Usage  : $RAM_USAGE%"
echo "Disk Usage : $DISK_USAGE%"
echo "Uptime     : $UPTIME"
echo "Processes  : $PROCESS_COUNT"

# ALERT GENERATION

if [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ]; then
    echo "WARNING: High CPU usage!"
    echo "$TIMESTAMP ALERT: High CPU usage: $CPU_USAGE%" >> logs/alerts.log
fi

if [ "$RAM_USAGE" -ge "$RAM_THRESHOLD" ]; then
    echo "WARNING: High RAM usage!"
    echo "$TIMESTAMP ALERT: High RAM usage: $RAM_USAGE%" >> logs/alerts.log
fi

if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    echo "WARNING: High Disk usage!"
    echo "$TIMESTAMP ALERT: High Disk usage: $DISK_USAGE%" >> logs/alerts.log
fi

echo "======================================"

# SAVE MONITORING HISTORY
echo "$TIMESTAMP,CPU=$CPU_USAGE%,RAM=$RAM_USAGE%,DISK=$DISK_USAGE%,PROCESSES=$PROCESS_COUNT" >> logs/server_health.log

echo "Monitoring report saved successfully!"

