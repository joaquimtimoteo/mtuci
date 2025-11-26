# 🚀 Deployment Guide

## Deploy New Application

### 1. Prepare Application
```bash
# Create app directory
mkdir -p /app/myproject
cd /app/myproject

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install flask gunicorn
```

### 2. Create Application
```python
# app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello from Fly.io!"

if __name__ == '__main__':
    app.run()
```

### 3. Deploy with Gunicorn
```bash
# Install gunicorn
pip install gunicorn

# Run in background
screen -dmS myapp bash -c \
  "source /app/myproject/venv/bin/activate && \
   gunicorn -w 4 -b 0.0.0.0:5000 app:app"
```

### 4. Configure Nginx
```nginx
location /myapp/ {
    proxy_pass http://localhost:5000/;
    proxy_set_header Host $host;
}
```
```bash
service nginx reload
```

### 5. Test
```bash
curl http://localhost:8080/myapp/
```

## Deploy with Docker
```bash
# Create Dockerfile
cat > Dockerfile << 'DOCKER'
FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
DOCKER

# Build and run
docker build -t myapp .
docker run -d --name myapp -p 5000:5000 myapp
```

## Zero-Downtime Deployment
```bash
# Build new version
docker build -t myapp:v2 .

# Start new container
docker run -d --name myapp-v2 -p 5001:5000 myapp:v2

# Update Nginx to point to new version
# ... update config ...
service nginx reload

# Stop old version
docker stop myapp
docker rm myapp

# Rename new version
docker rename myapp-v2 myapp
```

