#!/bin/bash

PID_FILE="/tmp/dr_forwarding.pid"

echo "🛑 Killing existing port-forward processes..."
pkill -f "kubectl port-forward"
sleep 2

# סגירת פורט DR אם קיים
if [ -f "$PID_FILE" ]; then
  DR_PID=$(cat "$PID_FILE")
  echo "🛑 Killing DR forwarding process PID $DR_PID"
  kill $DR_PID 2>/dev/null
  rm -f "$PID_FILE"
fi

echo "🚀 Starting port-forwarding for all services..."

kubectl port-forward service/backend 5000:5000 -n default > /dev/null 2>&1 &
kubectl port-forward service/frontend 3000:80 -n default > /dev/null 2>&1 &
kubectl port-forward service/pgadmin 5050:80 -n default > /dev/null 2>&1 &
kubectl port-forward -n prometheus service/prometheus 9090:9090 > /dev/null 2>&1 &
kubectl port-forward -n prometheus service/grafana 3001:3000 > /dev/null 2>&1 &
kubectl port-forward -n prometheus service/alertmanager 9093:9093 > /dev/null 2>&1 &

# 🎯 חדש: פורט-פורוורד ל־ArgoCD
kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null 2>&1 &
ARGO_PID=$!
echo "📌 ArgoCD port-forward PID: $ARGO_PID"

echo "✅ All port-forwarding processes are now running."
