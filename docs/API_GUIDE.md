# 📡 API Development Guide

## Quick Start

### 1. Flask API
```python
# /app/flask_api.py
from flask import Flask, jsonify, request
from datetime import datetime

app = Flask(__name__)

@app.route('/api/v1/status')
def status():
    return jsonify({
        "status": "online",
        "timestamp": datetime.now().isoformat(),
        "version": "1.0.0"
    })

@app.route('/api/v1/data', methods=['POST'])
def create_data():
    data = request.get_json()
    # Process data
    return jsonify({"success": True, "data": data}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

**Run:**
```bash
screen -dmS flask bash -c "source /app/venv/bin/activate && python /app/flask_api.py"
```

### 2. FastAPI
```python
# /app/fastapi_app.py
from fastapi import FastAPI
from pydantic import BaseModel
from datetime import datetime

app = FastAPI()

class Item(BaseModel):
    name: str
    value: float

@app.get("/")
def read_root():
    return {
        "message": "FastAPI running on Fly.io",
        "timestamp": datetime.now().isoformat()
    }

@app.post("/items/")
def create_item(item: Item):
    return {"item": item, "created": True}
```

**Run:**
```bash
screen -dmS fastapi bash -c "source /app/venv/bin/activate && uvicorn fastapi_app:app --host 0.0.0.0 --port 5000"
```

## Nginx Configuration for APIs
```nginx
location /api/ {
    proxy_pass http://localhost:5000/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
}
```

