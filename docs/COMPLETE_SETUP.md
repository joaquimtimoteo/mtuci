# 🚀 Fly.io MicroVM Infrastructure

Complete production-ready infrastructure setup running on Fly.io with Docker, Nginx, Python, and Tigris Storage.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Fly.io-purple.svg)
![Docker](https://img.shields.io/badge/docker-enabled-blue.svg)

## 🎯 Features

- ✅ **Fly.io MicroVM** - Ubuntu 22.04 on Firecracker
- ✅ **Docker** - Full container support with VFS driver
- ✅ **Nginx** - Reverse proxy and load balancer
- ✅ **Python 3.10** - With virtual environment
- ✅ **Tigris Storage** - S3-compatible object storage
- ✅ **PostgreSQL** - Database in Docker
- ✅ **Redis** - Caching layer
- ✅ **Node.js** - API runtime

## 📋 Quick Start

### Prerequisites

- Fly.io account ([sign up here](https://fly.io/))
- Tigris account ([sign up here](https://console.tigris.dev/))
- `flyctl` CLI installed

### 1. Clone Repository
```bash
git clone https://github.com/YOUR-USERNAME/flyio-microvm.git
cd flyio-microvm
```

### 2. Deploy to Fly.io
```bash
# Login to Fly.io
fly auth login

# Launch application
fly launch --name your-app-name --region ams --no-deploy

# Copy configuration files
cp fly.toml.example fly.toml
# Edit fly.toml with your app name

# Deploy
fly deploy
```

### 3. Connect via SSH
```bash
fly ssh console -a your-app-name
```

### 4. Setup Services
```bash
# Inside the VM
cd /app

# Start Docker
service docker start

# Start Nginx
service nginx start

# Run startup script
./startup.sh
```

## 🏗️ Architecture
```
┌─────────────────────────────────────────────┐
│          Fly.io MicroVM (Amsterdam)         │
├─────────────────────────────────────────────┤
│                                             │
│  Nginx (8080) → Reverse Proxy               │
│       ↓                                     │
│  ┌──────────┬──────────┬──────────┐        │
│  │  Docker  │  Python  │  Native  │        │
│  │  Apps    │  Apps    │  Apps    │        │
│  └──────────┴──────────┴──────────┘        │
│                                             │
│  Docker Containers:                         │
│  • Nginx (9090)                             │
│  • PostgreSQL (5432)                        │
│  • Redis (6379)                             │
│  • Node.js (3000)                           │
│                                             │
│  Tigris Storage (S3-compatible)             │
└─────────────────────────────────────────────┘
```

## 📚 Documentation

- [Complete Setup Guide](docs/COMPLETE_SETUP.md)
- [API Development](docs/API_GUIDE.md)
- [Docker Guide](docs/DOCKER_GUIDE.md)
- [Deployment Guide](docs/DEPLOYMENT_GUIDE.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)

## 🔧 Configuration

### Environment Variables

Create `.env` file or use Fly secrets:
```bash
# Set secrets
fly secrets set DATABASE_URL=postgresql://user:pass@host:5432/db
fly secrets set TIGRIS_ACCESS_KEY=xxx
fly secrets set TIGRIS_SECRET_KEY=xxx
```

### Tigris Storage

Configure AWS CLI with Tigris credentials:
```bash
aws configure set aws_access_key_id YOUR_KEY
aws configure set aws_secret_access_key YOUR_SECRET
aws configure set region auto
```

## 🛠️ Management Commands
```bash
# Check status
./vm_status.sh

# Start all services
./startup.sh

# Create backup
./backup.sh

# View logs
docker compose logs -f
tail -f /var/log/nginx/access.log
```

## 🐳 Docker Services

Manage services with Docker Compose:
```bash
# Start services
docker compose up -d

# Stop services
docker compose down

# View status
docker compose ps

# View logs
docker compose logs -f
```

## 📊 Monitoring
```bash
# System resources
htop

# Docker stats
docker stats

# Nginx status
curl http://localhost:8080/status
```

## 🔒 Security

- Change default passwords in `docker-compose.yml`
- Protect credentials: `chmod 600 ~/.aws/credentials`
- Use Fly secrets for sensitive data
- Enable firewall rules in Fly.io dashboard

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🆘 Support

- [Fly.io Documentation](https://fly.io/docs/)
- [Tigris Documentation](https://www.tigrisdata.com/docs/)
- [Issues](https://github.com/YOUR-USERNAME/flyio-microvm/issues)

## 🙏 Acknowledgments

- Fly.io for excellent microVM infrastructure
- Tigris for zero-egress object storage
- Docker for containerization
- Nginx for reverse proxy

---

**Made with ❤️ for developers who need fast, reliable infrastructure**
