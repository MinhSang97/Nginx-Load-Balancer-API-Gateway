#!/bin/bash

echo "🧪 Test Services Menu"
echo "===================="
echo ""
echo "Chọn service để test:"
echo "1) 🌐 Test Gateway (Nginx)"
echo "2) 🔐 Test Auth Service (Node.js)"
echo "3) 📦 Test Product Service (Python)"
echo "4) 🛒 Test Order Service (Java)"
echo "5) ❤️  Test All Services Health"
echo "6) 📊 Test All Endpoints"
echo "7) 🔄 Restart All Services"
echo "8) ❌ Thoát"
echo ""

read -p "Nhập lựa chọn (1-8): " choice

case $choice in
    1)
        echo ""
        echo "🌐 Testing Gateway..."
        echo "===================="
        echo ""
        echo "📍 Testing localhost endpoints:"
        echo ""
        
        echo "🔍 Health Check:"
        curl -s http://localhost/health || echo "❌ Failed"
        echo ""
        
        echo "🔍 Dev Info:"
        curl -s http://localhost/dev-info || echo "❌ Failed"
        echo ""
        
        echo "🔍 Services Status:"
        curl -s http://localhost/services || echo "❌ Failed"
        echo ""
        
        echo "🔍 Default Response:"
        curl -s http://localhost/ || echo "❌ Failed"
        echo ""
        ;;
    2)
        echo ""
        echo "🔐 Testing Auth Service (Node.js)..."
        echo "===================================="
        echo ""
        echo "📍 Testing auth endpoints:"
        echo ""
        
        echo "🔍 Auth Health:"
        curl -s http://localhost:8001/health || echo "❌ Failed"
        echo ""
        
        echo "🔍 Auth Info:"
        curl -s http://localhost:8001/ || echo "❌ Failed"
        echo ""
        
        echo "🔍 Through Gateway:"
        curl -s http://localhost/auth/ || echo "❌ Failed"
        echo ""
        ;;
    3)
        echo ""
        echo "📦 Testing Product Service (Python)..."
        echo "======================================="
        echo ""
        echo "📍 Testing product endpoints:"
        echo ""
        
        echo "🔍 Product Health:"
        curl -s http://localhost:8002/health || echo "❌ Failed"
        echo ""
        
        echo "🔍 Product Info:"
        curl -s http://localhost:8002/ || echo "❌ Failed"
        echo ""
        
        echo "🔍 Through Gateway:"
        curl -s http://localhost/products/ || echo "❌ Failed"
        echo ""
        
        echo "🔍 API Docs:"
        curl -s http://localhost/docs/ || echo "❌ Failed"
        echo ""
        ;;
    4)
        echo ""
        echo "🛒 Testing Order Service (Java)..."
        echo "=================================="
        echo ""
        echo "📍 Testing order endpoints:"
        echo ""
        
        echo "🔍 Order Health:"
        curl -s http://localhost:8003/health || echo "❌ Failed"
        echo ""
        
        echo "🔍 Order Info:"
        curl -s http://localhost:8003/ || echo "❌ Failed"
        echo ""
        
        echo "🔍 Through Gateway:"
        curl -s http://localhost/orders/ || echo "❌ Failed"
        echo ""
        ;;
    5)
        echo ""
        echo "❤️  Testing All Services Health..."
        echo "================================="
        echo ""
        
        echo "🌐 Gateway Health:"
        curl -s http://localhost/health || echo "❌ Gateway Failed"
        echo ""
        
        echo "🔐 Auth Service Health:"
        curl -s http://localhost:8001/health || echo "❌ Auth Failed"
        echo ""
        
        echo "📦 Product Service Health:"
        curl -s http://localhost:8002/health || echo "❌ Product Failed"
        echo ""
        
        echo "🛒 Order Service Health:"
        curl -s http://localhost:8003/health || echo "❌ Order Failed"
        echo ""
        ;;
    6)
        echo ""
        echo "📊 Testing All Endpoints..."
        echo "=========================="
        echo ""
        
        echo "🌐 Gateway Endpoints:"
        echo "  Health: $(curl -s http://localhost/health | head -c 50)..."
        echo "  Dev Info: $(curl -s http://localhost/dev-info | head -c 50)..."
        echo "  Services: $(curl -s http://localhost/services | head -c 50)..."
        echo ""
        
        echo "🔐 Auth Endpoints:"
        echo "  Direct: $(curl -s http://localhost:8001/ | head -c 50)..."
        echo "  Gateway: $(curl -s http://localhost/auth/ | head -c 50)..."
        echo ""
        
        echo "📦 Product Endpoints:"
        echo "  Direct: $(curl -s http://localhost:8002/ | head -c 50)..."
        echo "  Gateway: $(curl -s http://localhost/products/ | head -c 50)..."
        echo "  Docs: $(curl -s http://localhost/docs/ | head -c 50)..."
        echo ""
        
        echo "🛒 Order Endpoints:"
        echo "  Direct: $(curl -s http://localhost:8003/ | head -c 50)..."
        echo "  Gateway: $(curl -s http://localhost/orders/ | head -c 50)..."
        echo ""
        ;;
    7)
        echo ""
        echo "🔄 Restarting All Services..."
        echo "============================="
        echo ""
        
        echo "🛑 Stopping services..."
        docker-compose -f docker-compose.local-clean.yml down
        
        echo "🚀 Starting services..."
        docker-compose -f docker-compose.local-clean.yml up -d
        
        echo "⏳ Waiting for services to start..."
        sleep 10
        
        echo "✅ Services restarted!"
        echo ""
        echo "🔍 Quick health check:"
        curl -s http://localhost/health || echo "❌ Gateway not ready yet"
        echo ""
        ;;
    8)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Lựa chọn không hợp lệ!"
        exit 1
        ;;
esac

echo ""
echo "✅ Test completed!"
echo ""
echo "🛠️  Commands:"
echo "   📋 Logs: docker-compose -f docker-compose.local-clean.yml logs -f"
echo "   🔄 Restart: docker-compose -f docker-compose.local-clean.yml restart"
echo "   🛑 Stop: docker-compose -f docker-compose.local-clean.yml down"
