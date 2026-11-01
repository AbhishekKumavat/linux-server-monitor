
# Linux Server Monitoring and Automation System

A Linux-based monitoring and automation project developed using Bash scripting on Ubuntu 22.04 LTS.

## Features

- CPU utilization monitoring
- RAM utilization monitoring
- Disk space monitoring
- Running process monitoring
- Automated backup and recovery
- Cron-based scheduling
- Threshold-based alerts
- Alert logging and analysis
- Server health summary

## Tech Stack

- Ubuntu Linux
- Bash Scripting
- Cron
- Git and GitHub
- Oracle VirtualBox

## Project Structure

```text
linux-server-monitor/
├── config/
│   └── config.conf
├── scripts/
│   ├── monitor.sh
│   ├── process_check.sh
│   ├── backup.sh
│   └── health_summary.sh
├── logs/
├── backups/
└── README.md
```

## Execute Scripts

```bash
chmod +x scripts/*.sh

./scripts/monitor.sh
./scripts/process_check.sh
./scripts/backup.sh
./scripts/health_summary.sh
```

## Cron Automation

- Server monitoring every 5 minutes.
- Automated backup every day at 2 AM.

## Learning Outcomes

- Linux administration
- Bash scripting
- Process management
- System monitoring
- File permissions
- Backup and recovery
- Cron automation
- Log management
