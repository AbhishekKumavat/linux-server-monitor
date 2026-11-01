#!/bin/bash

echo "=========================================="
echo "       LINUX PROCESS MONITOR"
echo "=========================================="

echo "Current Date: $(date)"
echo ""

echo "TOP 10 CPU CONSUMING PROCESSES"

ps -eo pid,ppid,comm,%cpu,%mem --sort=-%cpu | head -11

echo ""
echo "TOTAL RUNNING PROCESSES"

ps -e --no-headers | wc -l

echo ""
echo "=========================================="
