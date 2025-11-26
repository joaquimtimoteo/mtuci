# 🐳 Docker Usage Guide

## Custom Docker Images

### Build Your Own Image
```dockerfile
# /app/Dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]
```

**Build and run:**
```bash
cd /app
docker build -t my-python-app .
docker run -d -p 5000:5000 my-python-app
```

## Docker Compose Examples

### Full Stack Application
```yaml
# /app/docker-compose.yml
version: '3.8'

services:
  frontend:
    image: nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - ./frontend:/usr/share/nginx/html
    depends_on:
      - backend

  backend:
    image: python:3.10-slim
    ports:
      - "5000:5000"
    environment:
      - DATABASE_URL=postgresql://postgres:senha123@db:5432/meudb
    command: python api.py
    depends_on:
      - db

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_PASSWORD: senha123
      POSTGRES_DB: meudb
    volumes:
      - postgres-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  cache:
    image: redis:alpine
    ports:
      - "6379:6379"

volumes:
  postgres-data:
```

## Useful Docker Commands
```bash
# Build from Dockerfile
docker build -t myapp .

# Run with environment variables
docker run -d \
  --name myapp \
  -p 5000:5000 \
  -e DATABASE_URL=xxx \
  -e API_KEY=yyy \
  myapp

# Execute command in running container
docker exec -it myapp bash
docker exec -it postgres psql -U postgres

# View resource usage
docker stats

# Clean up
docker system prune -a --volumes -f
```

