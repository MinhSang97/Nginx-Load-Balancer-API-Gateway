#!/bin/bash

# Script để tạo dummy SSL certificate cho blocking server

echo "🔐 Generating dummy SSL certificate for security blocking..."

# Tạo thư mục ssl nếu chưa có
mkdir -p nginx/ssl

# Tạo dummy certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout nginx/ssl/dummy.key \
    -out nginx/ssl/dummy.crt \
    -subj "/C=VN/ST=Hanoi/L=Hanoi/O=SecureGateway/OU=IT/CN=blocked"

echo "✅ Dummy SSL certificate generated successfully!"
echo "📁 Certificate files:"
echo "   - nginx/ssl/dummy.crt"
echo "   - nginx/ssl/dummy.key"
