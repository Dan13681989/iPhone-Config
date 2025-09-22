#!/bin/bash
echo "=== SYSTEM DASHBOARD ==="
echo "📊 Sync Status:"
git log --oneline -5
echo "🐳 Docker Status:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo "💾 Disk Usage:"
df -h | grep -v snap
echo "🌐 Network:"
curl -s ifconfig.me && echo
