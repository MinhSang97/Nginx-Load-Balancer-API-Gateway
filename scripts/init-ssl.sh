#!/bin/bash

# Script để khởi tạo SSL certificate cho domain apifincheck.husanenglish.online

set -e

DOMAIN="apifincheck.husanenglish.online"
EMAIL="admin@husanenglish.online"

echo "🚀 Initializing SSL certificate for $DOMAIN"

# Tạo thư mục cần thiết
mkdir -p ./nginx/ssl
mkdir -p ./logs

# Kiểm tra xem certificate đã tồn tại chưa
if [ -f "./nginx/ssl/live/$DOMAIN/fullchain.pem" ]; then
    echo "✅ SSL certificate already exists for $DOMAIN"
    exit 0
fi

echo "📋 Starting nginx without SSL first..."
docker-compose up -d nginx

echo "⏳ Waiting for nginx to be ready..."
sleep 10

echo "🔐 Requesting SSL certificate from Let's Encrypt..."
docker-compose run --rm certbot

echo "🔄 Reloading nginx with SSL configuration..."
docker-compose exec nginx nginx -s reload

echo "✅ SSL certificate setup completed!"
echo "🌐 Your API Gateway is now available at: https://$DOMAIN"
echo "📊 Server info: https://$DOMAIN/server-info"
