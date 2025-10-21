#!/bin/bash

echo "🏠 Setting up Local Development (Clean)"
echo "======================================"

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker-compose -f docker-compose.local-clean.yml down

# Clean up config files
echo "🧹 Cleaning up config files..."

# Disable production configs
mv nginx/conf.d/api-gateway.conf nginx/conf.d/api-gateway.conf.disabled 2>/dev/null || true
mv nginx/conf.d/load-balancer.conf.disabled nginx/conf.d/ 2>/dev/null || true
mv nginx/conf.d/security.conf.disabled nginx/conf.d/ 2>/dev/null || true
mv nginx/conf.d/production-gateway.conf.disabled nginx/conf.d/ 2>/dev/null || true
mv nginx/conf.d/external-services.conf.disabled nginx/conf.d/ 2>/dev/null || true

# Enable local configs (already in nginx-local folder)

# Create necessary directories
mkdir -p nginx/conf.d nginx/ssl logs backend1 backend2 backend3 scripts

# Set permissions
chmod +x scripts/*.sh

echo "📦 Starting local development containers..."
docker-compose -f docker-compose.local-clean.yml up -d --build

echo "⏳ Waiting for services to start..."
sleep 15

# Check service status
echo "🔍 Checking service status..."

check_service() {
    local service_name=$1
    local max_attempts=30
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        if docker-compose -f docker-compose.local-clean.yml ps | grep -q "$service_name.*Up"; then
            echo "✅ $service_name: Running"
            return 0
        else
            echo "⏳ $service_name: Still starting... (attempt $attempt/$max_attempts)"
            sleep 2
            ((attempt++))
        fi
    done
    
    echo "❌ $service_name: Failed to start after $max_attempts attempts"
    return 1
}

# Check all services
check_service "nginx-lb-gateway-local"
check_service "backend1-nodejs-local"
check_service "backend2-python-local"
check_service "backend3-java-local"

echo ""
echo "🎉 Local Development Setup Complete!"
echo ""
echo "📋 Available endpoints:"
echo "   🌐 Gateway: http://localhost"
echo "   ❤️  Health: http://localhost/health"
echo "   🔍 Dev Info: http://localhost/dev-info"
echo "   📋 Services: http://localhost/services"
echo ""
echo "🔧 API Endpoints:"
echo "   🔐 Auth: http://localhost/auth/"
echo "   👥 Users: http://localhost/users/"
echo "   📦 Products: http://localhost/products/"
echo "   🛒 Orders: http://localhost/orders/"
echo "   📖 Docs: http://localhost/docs/"
echo ""
echo "🛠️  Commands:"
echo "   📋 Logs: docker-compose -f docker-compose.local-clean.yml logs -f"
echo "   🔄 Restart: docker-compose -f docker-compose.local-clean.yml restart"
echo "   🛑 Stop: docker-compose -f docker-compose.local-clean.yml down"
