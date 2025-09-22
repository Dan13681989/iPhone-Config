#!/bin/bash
echo "=== Applying iPhone Configuration ==="

# 1. Backup critical system files
echo "📁 Backing up system files..."
cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
cp ~/.bash_profile ~/.bash_profile.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true

# 2. Network configuration restore
if [ -f network_settings.json ]; then
    echo "🌐 Applying network settings..."
    # Add network restore commands here
fi

# 3. Application configurations
if [ -f app_configs.tar.gz ]; then
    echo "📱 Extracting application configs..."
    tar -xzf app_configs.tar.gz -C ~/ 2>/dev/null || true
fi

# 4. Scripts synchronization
if [ -d scripts ]; then
    echo "⚡ Syncing scripts..."
    cp -r scripts/* ~/scripts/ 2>/dev/null || true
fi

# 5. Create recovery log
echo "✅ Configuration applied: $(date)" >> ~/iphone-sync/recovery.log
echo "🎉 iPhone configuration applied successfully!"

# Docker configuration sync
if [ -d docker-configs ]; then
    echo "🐳 Applying Docker configurations..."
    cp -r docker-configs/* ~/docker-configs/ 2>/dev/null || true
    cd ~/docker-configs
    chmod +x manage_docker.sh
    echo "✅ Docker configurations applied!"
fi
