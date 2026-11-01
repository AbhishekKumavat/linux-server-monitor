#!/bin/bash

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR" || exit 1

echo "======================================"
echo "       SERVER HEALTH SUMMARY"
echo "======================================"

echo "Generated: $(date)"
echo ""

echo "TOTAL MONITORING RECORDS:"
wc -l < logs/server_health.log

echo ""
echo "TOTAL ALERTS:"
grep -c "ALERT" logs/alerts.log

echo ""
echo "CPU ALERTS:"
grep -c "High CPU" logs/alerts.log

echo ""
echo "RAM ALERTS:"
grep -c "High RAM" logs/alerts.log

echo ""
echo "DISK ALERTS:"
grep -c "High Disk" logs/alerts.log

echo ""
echo "LATEST SERVER STATUS:"
tail -n 1 logs/server_health.log

echo ""
echo "======================================"
