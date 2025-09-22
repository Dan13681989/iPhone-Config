#!/bin/bash
echo "=== SYSTEM DASHBOARD ==="
echo "📊 Sync Status:"
git log --oneline -5
echo "🐳 Docker Status:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo "💾 Disk Usage:"
df -h | grep -v snap
echo "🌐 Network Check:"
IP=$(curl -s --connect-timeout 5 ifconfig.me 2>/dev/null)
if [ -n "$IP" ] && [ "${#IP}" -lt 20 ]; then
    echo "✅ Network: $IP"
else
    echo "⚠️  Network check failed (may be offline or blocked)"
fi
