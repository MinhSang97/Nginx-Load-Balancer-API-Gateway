#!/bin/bash

# Script để setup cron job cho SSL renewal

echo "🕐 Setting up SSL renewal cron job..."

# Tạo cron job để chạy mỗi ngày lúc 2:00 AM
(crontab -l 2>/dev/null; echo "0 2 * * * cd $(pwd) && ./scripts/renew-ssl.sh >> ./logs/cron.log 2>&1") | crontab -

echo "✅ Cron job setup completed!"
echo "📅 SSL certificate will be checked and renewed daily at 2:00 AM"
echo "📋 To view cron jobs: crontab -l"
echo "📋 To remove cron jobs: crontab -r"
