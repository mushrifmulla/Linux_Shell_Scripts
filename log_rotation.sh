#!/bin/bash

#Variables

LOG_DIR="/var/log"
LOG_FILE="/var/log/Log_Rotation.log"

#Ensure Log directory exists

if [ ! -d "$LOG_DIR" ]; then
	echo "[$(date)] Error: Log Directory $LOG_DIR doest exists!" >> "$LOG_FILE"
	exit1
fi

#Compress logs older than 7days less than 30 days

find "$LOG_DIR" -type f -name "*.log" -mtime +7 -mtime -30 ! -type "*.gz" -exec gz {} \; -exec echo "[$(date)] Compressed: {}" >> "$LOG_FILE" \;

#Delete files older than 30 days

find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -exec rm -rf {} \; -exec echo "[$(date)] Deleted: {}" >> "$LOG_FILE" \;

#Done

echo "[$(date)] Log Rotation successfully completed." >> "$LOG_FILE"




