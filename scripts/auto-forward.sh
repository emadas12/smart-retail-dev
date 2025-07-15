#!/bin/bash

echo "🕒 Waiting for main frontend/backend pods to be ready..."

# ממתין שהפוד frontend והbackend יהיו בסטטוס Running
kubectl wait --for=condition=ready pod -l app=frontend -n default --timeout=90s
kubectl wait --for=condition=ready pod -l app=backend -n default --timeout=90s

echo "✅ Pods are ready. Starting port-forwarding..."
bash ./scripts/start-dev.sh
