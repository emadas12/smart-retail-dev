#!/bin/bash

LOG_FILE="logs/failover.log"
PRIMARY_URL="http://localhost:3000"
CHECK_INTERVAL=10
DR_PID_FILE="/tmp/dr_forwarding.pid"
PRIMARY_PID_FILE="/tmp/primary_forwarding.pid"
DR_PORT=3002
PRIMARY_PORT=3000

# Ensure log directory exists
mkdir -p logs

echo "🔁 Monitoring PRIMARY every ${CHECK_INTERVAL} seconds..." | tee -a "$LOG_FILE"

while true; do
    TIMESTAMP=$(date)

    if curl --silent --max-time 3 "$PRIMARY_URL" > /dev/null; then
        echo "✅ $TIMESTAMP - Primary is UP" | tee -a "$LOG_FILE"

        # 🧹 Kill DR if running
        if [ -f "$DR_PID_FILE" ]; then
            DR_PID=$(cat "$DR_PID_FILE")
            if kill -0 $DR_PID 2>/dev/null; then
                echo "🔄 $TIMESTAMP - Switching BACK to Primary... Killing DR PID $DR_PID" | tee -a "$LOG_FILE"
                kill $DR_PID
            fi
            rm -f "$DR_PID_FILE"
        fi

        # 🔁 Forward Primary if not already forwarded
        if [ ! -f "$PRIMARY_PID_FILE" ]; then
            echo "🚀 $TIMESTAMP - Forwarding Primary Frontend on port $PRIMARY_PORT..." | tee -a "$LOG_FILE"
            (kubectl port-forward service/frontend $PRIMARY_PORT:80 -n default > /dev/null 2>&1) &
            echo $! > "$PRIMARY_PID_FILE"
            echo "🌐 $TIMESTAMP - Primary Frontend available at http://localhost:$PRIMARY_PORT" | tee -a "$LOG_FILE"
        fi

    else
        echo "❌ $TIMESTAMP - Primary is DOWN" | tee -a "$LOG_FILE"

        # 🧹 Kill Primary port-forward if running
        if [ -f "$PRIMARY_PID_FILE" ]; then
            PRIMARY_PID=$(cat "$PRIMARY_PID_FILE")
            if kill -0 $PRIMARY_PID 2>/dev/null; then
                echo "🛑 $TIMESTAMP - Killing Primary port-forward PID $PRIMARY_PID" | tee -a "$LOG_FILE"
                kill $PRIMARY_PID
            fi
            rm -f "$PRIMARY_PID_FILE"
        fi

        # 🚨 Start DR port-forward if not running
        if [ ! -f "$DR_PID_FILE" ]; then
            echo "🚨 $TIMESTAMP - Launching DR Frontend on port $DR_PORT..." | tee -a "$LOG_FILE"
            (kubectl port-forward service/frontend $DR_PORT:80 -n dr-region > /dev/null 2>&1) &
            echo $! > "$DR_PID_FILE"
            echo "🌐 $TIMESTAMP - DR Frontend running on http://localhost:$DR_PORT" | tee -a "$LOG_FILE"
        fi
    fi

    sleep $CHECK_INTERVAL
done
