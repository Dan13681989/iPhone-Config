#!/bin/bash
BACKUP_DIR="/Volumes/ADATA/backups"
mkdir -p $BACKUP_DIR
tar -czf $BACKUP_DIR/full_system_$(date +%Y%m%d_%H%M%S).tar.gz \
    ~/iphone-sync \
    ~/docker-configs \
    ~/Documents/iPhone-Config \
    2>/dev/null
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete
echo "✅ Backup completed: $(ls -la $BACKUP_DIR/*.tar.gz | tail -1)"
