#!/bin/bash

LOG_FILE="failover.log"
PRIMARY_URL="http://localhost:3000"
CHECK_INTERVAL=10
PID_FILE="/tmp/dr_forwarding.pid"
DR_PORT=3002

echo "🔁 Monitoring PRIMARY every ${CHECK_INTERVAL} seconds..." | tee -a "$LOG_FILE"

while true; do
    TIMESTAMP=$(date)
    
    if curl --silent --max-time 3 "$PRIMARY_URL" > /dev/null; then
        echo "✅ $TIMESTAMP - Primary is UP" | tee -a "$LOG_FILE"

        if [ -f "$PID_FILE" ]; then
            DR_PID=$(cat "$PID_FILE")
            echo "🔄 $TIMESTAMP - Switching BACK to Primary... Killing DR PID $DR_PID" | tee -a "$LOG_FILE"
            kill $DR_PID 2>/dev/null
            rm -f "$PID_FILE"
        fi
    else
        echo "❌ $TIMESTAMP - Primary is DOWN" | tee -a "$LOG_FILE"

        if [ ! -f "$PID_FILE" ]; then
            echo "🚨 $TIMESTAMP - Launching DR Frontend on port $DR_PORT..." | tee -a "$LOG_FILE"
            (kubectl port-forward service/frontend $DR_PORT:80 -n dr-region > /dev/null 2>&1) &
            echo $! > "$PID_FILE"
            echo "🌐 $TIMESTAMP - DR Frontend running on http://localhost:$DR_PORT" | tee -a "$LOG_FILE"
        fi
    fi
    sleep $CHECK_INTERVAL
done
