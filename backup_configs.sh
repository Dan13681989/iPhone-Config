#!/bin/bash
echo "📦 Creating configuration backup..."
tar -czf config_backup_$(date +%Y%m%d_%H%M%S).tar.gz \
    apply_config.sh \
    sync_config.json \
    network_settings.json 2>/dev/null || true
echo "✅ Backup created!"
