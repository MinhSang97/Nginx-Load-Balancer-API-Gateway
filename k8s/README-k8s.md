# Kubernetes Deployment Guide

## 🚀 **Automatic SSL Certificate Management**

This deployment uses **cert-manager** for automatic SSL certificate management with Let's Encrypt.

### **Prerequisites:**
- Kubernetes cluster (EKS, GKE, AKS, or local)
- kubectl configured
- Domain pointing to your cluster's LoadBalancer IP

### **Features:**
- ✅ **Automatic SSL certificates** via cert-manager
- ✅ **Let's Encrypt integration** (staging & production)
- ✅ **Auto-renewal** of SSL certificates
- ✅ **No hardcoded certificates**
- ✅ **Production-ready** security

## 📋 **Deployment Steps:**

### **1. Quick Setup:**
```bash
./scripts/setup-k8s.sh
```

### **2. Manual Setup:**
```bash
# Install cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml

# Wait for cert-manager to be ready
kubectl wait --for=condition=available --timeout=300s deployment/cert-manager -n cert-manager

# Create namespace
kubectl apply -f k8s/namespace.yaml

# Setup Let's Encrypt ClusterIssuer
kubectl apply -f k8s/cert-manager-setup.yaml

# Deploy applications
kubectl apply -f k8s/nginx-configmap.yaml
kubectl apply -f k8s/backend1-deployment.yaml
kubectl apply -f k8s/backend2-deployment.yaml
kubectl apply -f k8s/backend3-deployment.yaml
kubectl apply -f k8s/nginx-deployment.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/hpa.yaml
```

## 🔧 **Configuration:**

### **Update Email for Let's Encrypt:**
```yaml
# Edit k8s/cert-manager-setup.yaml
spec:
  acme:
    email: your-email@example.com  # Change this
```

### **Update Domain:**
```yaml
# Edit k8s/ingress.yaml
spec:
  tls:
  - hosts:
    - your-domain.com  # Change this
  rules:
  - host: your-domain.com  # Change this
```

## 🧪 **Testing:**

```bash
# Test deployment
./scripts/test-k8s.sh

# Check certificates
kubectl get certificates -n nginx-gateway

# Check cert-manager logs
kubectl logs -f deployment/cert-manager -n cert-manager
```

## 📊 **Monitoring:**

```bash
# Check all resources
kubectl get all -n nginx-gateway

# Check certificates
kubectl get certificates -n nginx-gateway

# Check ingress
kubectl get ingress -n nginx-gateway

# Check HPA
kubectl get hpa -n nginx-gateway
```

## 🔒 **Security Features:**

- ✅ **Automatic SSL/TLS** via cert-manager
- ✅ **Let's Encrypt certificates** (free & trusted)
- ✅ **Auto-renewal** (no manual intervention)
- ✅ **Rate limiting** via ingress annotations
- ✅ **Security headers** via nginx config
- ✅ **Auto-scaling** via HPA
- ✅ **Health checks** via probes

## 🛠️ **Troubleshooting:**

### **Certificate Issues:**
```bash
# Check certificate status
kubectl describe certificate apifincheck-tls -n nginx-gateway

# Check cert-manager logs
kubectl logs -f deployment/cert-manager -n cert-manager
```

### **DNS Issues:**
```bash
# Check if domain resolves to LoadBalancer IP
nslookup apifincheck.husanenglish.online

# Check ingress status
kubectl describe ingress nginx-gateway-ingress -n nginx-gateway
```

### **Service Issues:**
```bash
# Check service endpoints
kubectl get endpoints -n nginx-gateway

# Check pod logs
kubectl logs -f deployment/nginx-gateway -n nginx-gateway
```

## 🚀 **Production Checklist:**

- [ ] Update email in `cert-manager-setup.yaml`
- [ ] Update domain in `ingress.yaml`
- [ ] Configure DNS to point to LoadBalancer IP
- [ ] Test SSL certificate generation
- [ ] Verify auto-scaling works
- [ ] Monitor certificate renewal
- [ ] Test all endpoints
- [ ] Configure monitoring/alerting
