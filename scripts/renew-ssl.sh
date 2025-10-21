#!/bin/bash

# Script để tự động renew SSL certificate

set -e

DOMAIN="apifincheck.husanenglish.online"

echo "🔄 Starting SSL certificate renewal for $DOMAIN"

# Kiểm tra certificate có sắp hết hạn không (30 ngày)
if docker-compose exec nginx openssl x509 -in /etc/letsencrypt/live/$DOMAIN/cert.pem -checkend 2592000 -noout; then
    echo "✅ Certificate is still valid for more than 30 days"
    exit 0
fi

echo "⚠️  Certificate expires soon, renewing..."

# Renew certificate
docker-compose run --rm certbot renew

# Reload nginx
docker-compose exec nginx nginx -s reload

echo "✅ SSL certificate renewed successfully!"

# Log renewal
echo "$(date): SSL certificate renewed for $DOMAIN" >> ./logs/ssl-renewal.log
