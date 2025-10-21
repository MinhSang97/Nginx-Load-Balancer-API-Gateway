#!/bin/bash

echo "🧪 Testing Kubernetes Deployment"
echo "==============================="
echo ""

# Get external IP
EXTERNAL_IP=$(kubectl get service nginx-gateway-service -n nginx-gateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null)

if [ -z "$EXTERNAL_IP" ]; then
    echo "❌ External IP not found. Service might not be ready yet."
    echo "Checking service status..."
    kubectl get services -n nginx-gateway
    exit 1
fi

echo "🌐 External IP: $EXTERNAL_IP"
echo ""

echo "🔍 Testing endpoints:"
echo "===================="

echo "1. Health Check:"
curl -s "http://$EXTERNAL_IP/health" || echo "❌ Failed"
echo ""

echo "2. Server Info:"
curl -s "http://$EXTERNAL_IP/server-info" || echo "❌ Failed"
echo ""

echo "3. Auth Service:"
curl -s "http://$EXTERNAL_IP/auth/" || echo "❌ Failed"
echo ""

echo "4. Users Service:"
curl -s "http://$EXTERNAL_IP/users/" || echo "❌ Failed"
echo ""

echo "5. Products Service:"
curl -s "http://$EXTERNAL_IP/products/" || echo "❌ Failed"
echo ""

echo "6. Orders Service:"
curl -s "http://$EXTERNAL_IP/orders/" || echo "❌ Failed"
echo ""

echo "7. API Docs:"
curl -s "http://$EXTERNAL_IP/docs/" || echo "❌ Failed"
echo ""

echo "📊 Pod Status:"
kubectl get pods -n nginx-gateway
echo ""

echo "📈 HPA Status:"
kubectl get hpa -n nginx-gateway
echo ""

echo "✅ Testing completed!"
