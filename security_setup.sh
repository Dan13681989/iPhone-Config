#!/bin/bash
echo "🔒 Enhancing security..."
mkdir -p ~/secure/{scripts,configs,backups}
chmod 700 ~/secure
find ~/iphone-sync -name "*.sh" -exec chmod 700 {} \;
find ~/docker-configs -name "*.sh" -exec chmod 700 {} \;
echo "✅ Security enhancements applied"
