#!/bin/bash

echo "🚀 Iniciando serviços da MicroVM..."

# Iniciar Docker
service docker start
sleep 2

# Iniciar Nginx
service nginx start

# Iniciar containers com Docker Compose
cd /app
docker compose up -d

# Ativar venv Python
source /app/venv/bin/activate

echo "✅ Todos os serviços iniciados!"
/app/vm_status.sh
