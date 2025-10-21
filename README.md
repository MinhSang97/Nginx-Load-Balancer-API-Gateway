# Nginx Load Balancer & API Gateway với Docker

Hệ thống nginx load balancer và API gateway cho microservices với các ngôn ngữ lập trình khác nhau.

## 🏗️ Kiến trúc hệ thống

```
┌─────────────────┐
│   Nginx LB      │ ← Port 80
│   & Gateway     │
└─────────────────┘
         │
    ┌────┴────┐
    │         │
┌───▼───┐ ┌───▼───┐ ┌───▼───┐
│Node.js│ │Python │ │ Java  │
│:3000  │ │:8000  │ │:8080  │
└───────┘ └───────┘ └───────┘
```

## 🚀 Quick Start

### **Cách nhanh nhất - Chạy script tự động**
```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/nginx-load-balancer.git
cd nginx-load-balancer

# Chạy script chính (menu lựa chọn)
./scripts/start-clean.sh
```

### **Hoặc chạy trực tiếp cho từng môi trường**

#### 🏠 **Local Development**
```bash
# Chạy local development
./scripts/setup-local-clean.sh
```

#### 🌐 **Production (Full Features)**
```bash
# Chạy production với đầy đủ tính năng
./scripts/setup-production-clean.sh
```

### **Hoặc setup thủ công**

#### 🏠 **Local Development (Khuyến nghị cho demo)**
```bash
# 1. Clone và setup
git clone https://github.com/YOUR_USERNAME/nginx-load-balancer.git
cd nginx-load-balancer

# 2. Setup local development
./scripts/setup-local-clean.sh
```

#### 🌐 **Production với Domain thật**
```bash
# 1. Setup production
./scripts/setup-production-clean.sh

# 2. Cấu hình DNS
# A    apifincheck.husanenglish.online    -> YOUR_SERVER_IP
```

## 📖 **Cấu trúc dự án**

```
nginx-load-balancer/
├── nginx-local/           # 🏠 Local Development
│   ├── nginx.conf         # Simple config cho local
│   └── conf.d/
│       └── local-gateway.conf
│
├── nginx-prod/            # 🌐 Production
│   ├── nginx.conf         # Full security config
│   └── conf.d/
│       ├── api-gateway.conf
│       ├── load-balancer.conf
│       └── security.conf
│
├── Dockerfile.local       # 🏠 Local Dockerfile
├── Dockerfile.prod        # 🌐 Production Dockerfile
├── docker-compose.local-clean.yml
├── docker-compose.prod-clean.yml
└── scripts/
    ├── start-clean.sh
    ├── setup-local-clean.sh
    ├── setup-production-clean.sh
    └── test-services.sh
```

## 🧪 **Testing Services**

```bash
# Test services menu
./scripts/test-services.sh

# Hoặc từ menu chính
./scripts/start-clean.sh
# Chọn 3) 🧪 Test Services
```

### **Test Options:**
1. 🌐 Test Gateway (Nginx)
2. 🔐 Test Auth Service (Node.js)
3. 📦 Test Product Service (Python)
4. 🛒 Test Order Service (Java)
5. ❤️ Test All Services Health
6. 📊 Test All Endpoints
7. 🔄 Restart All Services

## 📚 API Endpoints

### 🏠 **Local Development (localhost)**
- `GET http://localhost/health` - Health check
- `GET http://localhost/dev-info` - Development info
- `GET http://localhost/services` - Services status
- `GET http://localhost/auth/` - Authentication
- `GET http://localhost/users/` - User management
- `GET http://localhost/products/` - Product management
- `GET http://localhost/orders/` - Order management
- `GET http://localhost/docs/` - API documentation

### 🌐 **Production (apifincheck.husanenglish.online)**
- `GET https://apifincheck.husanenglish.online/health` - Health check
- `GET https://apifincheck.husanenglish.online/server-info` - Server info
- `GET https://apifincheck.husanenglish.online/auth/` - Authentication
- `GET https://apifincheck.husanenglish.online/users/` - User management
- `GET https://apifincheck.husanenglish.online/products/` - Product management
- `GET https://apifincheck.husanenglish.online/orders/` - Order management
- `GET https://apifincheck.husanenglish.online/docs/` - API documentation

## 🔒 **Security Features (Production)**

- ✅ **SSL/TLS encryption** với Let's Encrypt
- ✅ **IP blocking** - chỉ domain mới truy cập được
- ✅ **Rate limiting** - chống DDoS
- ✅ **Security headers** - HSTS, XSS Protection
- ✅ **Connection limiting** - giới hạn kết nối
- ✅ **Bot & scanner blocking** - chặn malicious requests
- ✅ **Auto SSL renewal** - tự động gia hạn certificate
- ✅ **Load balancing** - phân tải requests
- ✅ **API Gateway** - routing thông minh

## 🛠️ **Commands**

### **Local Development:**
```bash
# Start
./scripts/setup-local-clean.sh

# Test
./scripts/test-services.sh

# Logs
docker-compose -f docker-compose.local-clean.yml logs -f

# Restart
docker-compose -f docker-compose.local-clean.yml restart

# Stop
docker-compose -f docker-compose.local-clean.yml down
```

### **Production:**
```bash
# Start
./scripts/setup-production-clean.sh

# SSL Renewal
./scripts/renew-ssl.sh

# Logs
docker-compose -f docker-compose.prod-clean.yml logs -f

# Restart
docker-compose -f docker-compose.prod-clean.yml restart

# Stop
docker-compose -f docker-compose.prod-clean.yml down
```

## 📋 **Requirements**

- Docker & Docker Compose
- Git
- Domain (for production)
- SSL certificate (auto-generated)

## 🤝 **Contributing**

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 **Author**

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/yourusername)

## 🙏 **Acknowledgments**

- Nginx for the amazing load balancer
- Docker for containerization
- Let's Encrypt for SSL certificates