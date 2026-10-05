#!/bin/bash

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
DATE_NOW=$(date "+%Y-%m-%d %H:%M:%S")

echo "$DATE_NOW - Використання диска: ${DISK_USAGE}%" | tee -a metrics.log

if [[ "$DISK_USAGE" -ge 80 ]]; then
    echo "[WARNING] Місце на диску вичерпується!"
fi
