#!/bin/bash

echo "☸️  Setting up Kubernetes Deployment"
echo "==================================="
echo ""

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl is not installed!"
    echo "Please install kubectl first: https://kubernetes.io/docs/tasks/tools/"
    exit 1
fi

# Check if cluster is accessible
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ Cannot connect to Kubernetes cluster!"
    echo "Please ensure your kubeconfig is set up correctly"
    exit 1
fi

echo "✅ Kubernetes cluster is accessible"

# Create namespace
echo "📁 Creating namespace..."
kubectl apply -f k8s/namespace.yaml

# Install cert-manager for automatic SSL certificate management
echo "🔐 Setting up cert-manager for automatic SSL certificates..."
echo "Installing cert-manager..."
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml

echo "⏳ Waiting for cert-manager to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/cert-manager -n cert-manager
kubectl wait --for=condition=available --timeout=300s deployment/cert-manager-cainjector -n cert-manager
kubectl wait --for=condition=available --timeout=300s deployment/cert-manager-webhook -n cert-manager

echo "⚙️  Setting up Let's Encrypt ClusterIssuer..."
kubectl apply -f k8s/cert-manager-setup.yaml

# Create ConfigMaps
echo "⚙️  Creating ConfigMaps..."
kubectl apply -f k8s/nginx-configmap.yaml

# Deploy backend services
echo "🚀 Deploying backend services..."
kubectl apply -f k8s/backend1-deployment.yaml
kubectl apply -f k8s/backend2-deployment.yaml
kubectl apply -f k8s/backend3-deployment.yaml

# Deploy nginx gateway
echo "🌐 Deploying nginx gateway..."
kubectl apply -f k8s/nginx-deployment.yaml

# Create ingress
echo "🔗 Creating ingress..."
kubectl apply -f k8s/ingress.yaml

# Setup HPA
echo "📈 Setting up Horizontal Pod Autoscaler..."
kubectl apply -f k8s/hpa.yaml

echo ""
echo "⏳ Waiting for deployments to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/nginx-gateway -n nginx-gateway
kubectl wait --for=condition=available --timeout=300s deployment/backend1-nodejs -n nginx-gateway
kubectl wait --for=condition=available --timeout=300s deployment/backend2-python -n nginx-gateway
kubectl wait --for=condition=available --timeout=300s deployment/backend3-java -n nginx-gateway

echo ""
echo "🎉 Kubernetes deployment completed!"
echo ""
echo "📋 Deployment Status:"
kubectl get pods -n nginx-gateway
echo ""
kubectl get services -n nginx-gateway
echo ""
kubectl get ingress -n nginx-gateway
echo ""
kubectl get hpa -n nginx-gateway

echo ""
echo "🌐 Access your application:"
echo "   External IP: $(kubectl get service nginx-gateway-service -n nginx-gateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
echo "   Domain: https://apifincheck.husanenglish.online"
echo ""
echo "🛠️  Useful commands:"
echo "   📋 Pods: kubectl get pods -n nginx-gateway"
echo "   📊 Logs: kubectl logs -f deployment/nginx-gateway -n nginx-gateway"
echo "   🔄 Scale: kubectl scale deployment nginx-gateway --replicas=5 -n nginx-gateway"
echo "   🛑 Delete: kubectl delete namespace nginx-gateway"
