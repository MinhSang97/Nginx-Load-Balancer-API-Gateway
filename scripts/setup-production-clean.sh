#!/bin/bash

echo "🌐 Setting up Production (Full Features)"
echo "========================================"

# Get domain from user
read -p "Nhập domain của bạn (ví dụ: apifincheck.husanenglish.online): " domain

if [ -z "$domain" ]; then
    echo "❌ Domain không được để trống!"
    exit 1
fi

echo "📋 Domain: $domain"
echo "⚠️  Đảm bảo DNS record đã được cấu hình:"
echo "   A    $domain    -> YOUR_SERVER_IP"
echo ""

read -p "DNS đã được cấu hình chưa? (y/n): " dns_ready

if [ "$dns_ready" != "y" ]; then
    echo "❌ Vui lòng cấu hình DNS trước khi tiếp tục!"
    exit 1
fi

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker-compose -f docker-compose.prod-clean.yml down

# Clean up config files
echo "🧹 Setting up production configs..."

# Disable local configs
mv nginx/conf.d/simple.conf nginx/conf.d/simple.conf.disabled 2>/dev/null || true
mv nginx/conf.d/local-simple.conf nginx/conf.d/local-simple.conf.disabled 2>/dev/null || true

# Enable production configs
mv nginx/conf.d/api-gateway.conf.disabled nginx/conf.d/api-gateway.conf 2>/dev/null || true
mv nginx/conf.d/load-balancer.conf.disabled nginx/conf.d/load-balancer.conf 2>/dev/null || true
mv nginx/conf.d/security.conf.disabled nginx/conf.d/security.conf 2>/dev/null || true
mv nginx/conf.d/production-gateway.conf.disabled nginx/conf.d/production-gateway.conf 2>/dev/null || true
mv nginx/conf.d/external-services.conf.disabled nginx/conf.d/external-services.conf 2>/dev/null || true

# Update domain in api-gateway.conf
sed -i "s/apifincheck\.husanenglish\.online/$domain/g" nginx/conf.d/api-gateway.conf

# Create necessary directories
mkdir -p nginx/conf.d nginx/ssl logs backend1 backend2 backend3 scripts

# Set permissions
chmod +x scripts/*.sh

# Generate dummy certificate
echo "🔐 Generating dummy SSL certificate..."
./scripts/generate-dummy-cert.sh

echo "📦 Starting production containers..."
docker-compose -f docker-compose.prod-clean.yml up -d

echo "⏳ Waiting for services to start..."
sleep 15

# Test domain
echo "🔍 Testing domain accessibility..."
if curl -s -I http://$domain > /dev/null; then
    echo "✅ Domain accessible: OK"
else
    echo "❌ Domain not accessible: Failed"
    echo "⚠️  Kiểm tra DNS configuration!"
fi

# Initialize SSL
echo "🔐 Initializing SSL certificate..."
./scripts/init-ssl.sh

# Setup auto-renewal
echo "🔄 Setting up auto-renewal..."
./scripts/setup-cron.sh

echo ""
echo "🎉 Production Setup Complete with Full Features!"
echo ""
echo "📋 Available endpoints:"
echo "   🌐 Gateway: https://$domain"
echo "   📊 Server Info: https://$domain/server-info"
echo "   ❤️  Health: https://$domain/health"
echo ""
echo "🔒 Security Features:"
echo "   🛡️  SSL/TLS encryption"
echo "   🚫 IP blocking (chỉ domain mới truy cập được)"
echo "   🛡️  Rate limiting & DDoS protection"
echo "   🔐 Security headers (HSTS, XSS Protection)"
echo "   🚨 Connection limiting"
echo "   🛡️  Bot & scanner blocking"
echo ""
echo "📚 API Endpoints:"
echo "   🔐 Auth: https://$domain/auth/"
echo "   👥 Users: https://$domain/users/"
echo "   📦 Products: https://$domain/products/"
echo "   🛒 Orders: https://$domain/orders/"
echo "   📖 Docs: https://$domain/docs/"
echo ""
echo "🛠️  Commands:"
echo "   📋 Logs: docker-compose -f docker-compose.prod-clean.yml logs -f"
echo "   🔄 Restart: docker-compose -f docker-compose.prod-clean.yml restart"
echo "   🛑 Stop: docker-compose -f docker-compose.prod-clean.yml down"
echo "   🔐 SSL Renewal: ./scripts/renew-ssl.sh"
