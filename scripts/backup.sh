#!/bin/bash

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="/tmp/backup_$TIMESTAMP.tar.gz"

echo "📦 Criando backup..."

# Criar backup
tar -czf $BACKUP_FILE /app /etc/nginx /etc/docker

# Upload para Tigris
aws s3 cp $BACKUP_FILE s3://meu-bucket-fly/backups/ --endpoint-url https://t3.storage.dev

# Limpar
rm $BACKUP_FILE

echo "✅ Backup concluído: backup_$TIMESTAMP.tar.gz"
