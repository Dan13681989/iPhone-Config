#!/bin/bash
echo "🔄 Resetting sync system..."
git fetch origin
git reset --hard origin/main
echo "✅ Sync system reset to latest version"
