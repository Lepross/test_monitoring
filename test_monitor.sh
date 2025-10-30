#!/bin/bash

LOG_FILE="/var/log/monitoring.log"
MONITORING_URL="https://test.com/monitoring/test/api"
PROCESS_NAME="test"
PID_FILE="/var/run/test_monitor.pid"
PREVIOUS_PID=""

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

if [[ -f "$PID_FILE" ]]; then
    PREVIOUS_PID=$(cat "$PID_FILE")
fi

CURRENT_PID=$(pgrep -x "$PROCESS_NAME")

if [[ -n "$CURRENT_PID" ]]; then
    echo "$CURRENT_PID" > "$PID_FILE"
fi

if [[ -z "$CURRENT_PID" ]]; then
    exit 0
fi

if [[ -n "$PREVIOUS_PID" && "$PREVIOUS_PID" != "$CURRENT_PID" ]]; then
    log_message "PROCESS_RESTART: Process '$PROCESS_NAME' restarted. New PID: $CURRENT_PID, Previous PID: $PREVIOUS_PID"
fi

if curl -s -f --connect-timeout 10 --retry 2 "$MONITORING_URL" > /dev/null; then
    log_message "MONITORING_SUCCESS: Successfully pinged monitoring server"
else
    log_message "MONITORING_ERROR: Monitoring server is unavailable"
fi