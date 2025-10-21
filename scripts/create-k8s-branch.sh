#!/bin/bash

echo "🌿 Creating K8s Feature Branch"
echo "==============================="
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📁 Initializing Git repository..."
    git init
    git add .
    git commit -m "Initial commit: Nginx Load Balancer & API Gateway"
fi

# Create and checkout k8s branch
echo "🌿 Creating k8s-feature branch..."
git checkout -b k8s-feature

echo "📦 Adding K8s files..."
git add k8s/
git add scripts/setup-k8s.sh
git add scripts/test-k8s.sh
git add scripts/start-clean.sh

echo "💾 Committing K8s features..."
git commit -m "feat: Add Kubernetes support with cert-manager

- Add K8s manifests for all services
- Add cert-manager for automatic SSL certificates
- Add HPA for auto-scaling
- Add ingress with SSL termination
- Add setup and test scripts for K8s
- Remove hardcoded SSL certificates
- Add comprehensive K8s documentation"

echo "🚀 Pushing k8s-feature branch..."
git push -u origin k8s-feature

echo ""
echo "✅ K8s feature branch created successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Go to GitHub repository"
echo "2. Create Pull Request from 'k8s-feature' to 'main'"
echo "3. Add reviewers and assignees"
echo "4. Merge after review"
echo ""
echo "🔗 GitHub will show you the PR creation link"
