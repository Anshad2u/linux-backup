#!/bin/bash
# Backup Script for Linux Mint
# Usage: ./backup.sh

BACKUP_DIR="/media/anshad/76E8-CACF"
DATE=$(date +%Y%m%d_%H%M%S)

echo "Starting backup at $DATE"

# Check if backup drive is mounted
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Error: Backup drive not mounted at $BACKUP_DIR"
    exit 1
fi

# Create backup folder
mkdir -p "$BACKUP_DIR/home_backup_$DATE"

# Backup home directory (excluding cache, temp)
echo "Backing up /home/anshad..."
rsync -av \
    --exclude='.cache' \
    --exclude='.local/share/Trash' \
    --exclude='*/__pycache__' \
    --exclude='*/.git/objects' \
    --progress \
    /home/anshad/ \
    "$BACKUP_DIR/home_backup_$DATE/"

# Fix permissions
echo "Fixing permissions..."
sudo chown -R anshad:anshad "$BACKUP_DIR/home_backup_$DATE"

echo "Backup complete!"
echo "Backup location: $BACKUP_DIR/home_backup_$DATE"
