#!/bin/bash
echo "🚀 DEPLOYING COMPLETE SYSTEM..."
cd ~/iphone-sync && git pull origin main
cd ~/docker-configs && ./manage_docker.sh stop
cp -r ~/iphone-sync/docker-configs/* ~/docker-configs/
cd ~/docker-configs && ./manage_docker.sh start
cd ~/iphone-sync && python3 sync_monitor.py &
echo "✅ SYSTEM DEPLOYED SUCCESSFULLY!"
