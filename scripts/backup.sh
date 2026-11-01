
#!/bin/bash

# Linux Automated Backup System

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$PROJECT_DIR" || exit 1

# Generate timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Backup configuration
SOURCE="demo_data"
DESTINATION="backups"

# Create backup directory if missing
mkdir -p "$DESTINATION"

# Backup filename
BACKUP_FILE="$DESTINATION/backup_$TIMESTAMP.tar.gz"

echo "===================================="
echo "       LINUX BACKUP SYSTEM"
echo "===================================="

echo "Starting backup..."

# Create compressed backup
if tar -czf "$BACKUP_FILE" "$SOURCE"; then

    echo "Backup completed successfully!"
    echo "Backup file: $BACKUP_FILE"

else

    echo "ERROR: Backup failed!"
    exit 1

fi

echo "===================================="
