#!/bin/bash
echo "🩺 SYSTEM HEALTH CHECK"
echo "======================"

# Check Git status
echo "📊 Git Status:"
if git status | grep -q "nothing to commit"; then
    echo "✅ Repository clean"
else
    echo "⚠️  Uncommitted changes"
fi

# Check Docker
echo "🐳 Docker Status:"
if docker ps > /dev/null 2>&1; then
    echo "✅ Docker running"
    RUNNING_CONTAINERS=$(docker ps -q | wc -l | tr -d ' ')
    echo "📦 Running containers: $RUNNING_CONTAINERS"
else
    echo "❌ Docker not available"
fi

# Check disk space
echo "💾 Disk Space:"
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -lt 80 ]; then
    echo "✅ Disk usage: ${DISK_USAGE}%"
else
    echo "⚠️  High disk usage: ${DISK_USAGE}%"
fi

# Check backup directory
echo "💿 Backup Status:"
if [ -d "/Volumes/ADATA/backups" ]; then
    BACKUP_COUNT=$(ls /Volumes/ADATA/backups/*.tar.gz 2>/dev/null | wc -l | tr -d ' ')
    echo "✅ Backup directory exists ($BACKUP_COUNT backups)"
else
    echo "⚠️  Backup directory not found"
fi

echo "======================"
echo "Health check completed at: $(date)"
