#!/bin/bash

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
DATE_NOW=$(date "+%Y-%m-%d %H:%M:%S")
RAM_INFO=$(free -m | awk 'NR==2 {printf "%d", $3/$2*100}')
CPU_LOAD=$(awk '{print $1}' /proc/loadavg)
CPU_INT=$(awk '{print int($1)}' /proc/loadavg)

LOG_FILE=metrics.log

echo "$DATE_NOW - Використання оперативної пам'яті: ${RAM_INFO}%" | tee -a "$LOG_FILE"
if [[ "$RAM_INFO" -ge 80 ]]; then
	echo "[WARNING] Оперативна пам'ять закінчується!" | tee -a "$LOG_FILE"
else
	echo "[OK] Оперативна пам'ять в нормі." | tee -a "$LOG_FILE"
fi

echo "$DATE_NOW - Використання диска: ${DISK_USAGE}%" | tee -a "$LOG_FILE"
if [[ "$DISK_USAGE" -ge 80 ]]; then
	echo "[WARNING] Місце на диску вичерпується!" | tee -a "$LOG_FILE"
else
	echo "[OK] Місця на диску достатньо" | tee -a "$LOG_FILE"
fi

echo "$DATE_NOW - CPU Load (1 min avg): ${CPU_LOAD}" | tee -a "$LOG_FILE"
if [[ "$CPU_INT" -ge 2 ]]; then
	echo "[WARNING] Високе навантаження процесора!" | tee -a "$LOG_FILE"
else
	echo "[OK] Навантаження CPU в нормі." | tee -a "$LOG_FILE"
fi

echo "" | tee -a "$LOG_FILE"
