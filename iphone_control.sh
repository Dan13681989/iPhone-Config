#!/bin/bash
echo "📱 iPhone Control Panel"
echo "1. Sync to Mac"
echo "2. Check Docker Status" 
echo "3. Update Web Content"
echo "4. System Health"
read -p "Choose option: " choice
case $choice in
    1) cd ~/iPhone-Config && ./push_config.sh ;;
    2) ssh user@mac-ip "cd ~/docker-configs && ./manage_docker.sh status" ;;
    3) nano ~/iPhone-Config/docker-configs/html/index.html ;;
    4) ssh user@mac-ip "cd ~/iphone-sync && ./system_dashboard.sh" ;;
    *) echo "Invalid option" ;;
esac
