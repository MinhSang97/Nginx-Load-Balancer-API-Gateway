#!/bin/bash

echo "🚀 Nginx Load Balancer & API Gateway (Clean Structure)"
echo "====================================================="
echo ""
echo "Chọn môi trường:"
echo "1) 🏠 Local Development (nginx-local folder)"
echo "2) 🌐 Production (nginx-prod folder)"
echo "3) ☸️  Kubernetes Cluster"
echo "4) 🧪 Test Services"
echo "5) ❌ Thoát"
echo ""

read -p "Nhập lựa chọn (1-5): " choice

case $choice in
    1)
        echo ""
        echo "🏠 Starting Local Development..."
        ./scripts/setup-local-clean.sh
        ;;
    2)
        echo ""
        echo "🌐 Starting Production..."
        ./scripts/setup-production-clean.sh
        ;;
    3)
        echo ""
        echo "☸️  Starting Kubernetes Deployment..."
        ./scripts/setup-k8s.sh
        ;;
    4)
        echo ""
        echo "🧪 Testing Services..."
        ./scripts/test-services.sh
        ;;
    5)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Lựa chọn không hợp lệ!"
        exit 1
        ;;
esac
