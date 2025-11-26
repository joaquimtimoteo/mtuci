#!/bin/bash

echo "════════════════════════════════════════════════"
echo "    🚀 MicroVM Status Dashboard"
echo "════════════════════════════════════════════════"
echo ""

echo "📊 SISTEMA:"
echo "  Uptime: $(uptime -p)"
echo "  Memória: $(free -h | awk 'NR==2{printf "  Usado: %s / Total: %s (%.2f%%)", $3,$2,$3*100/$2}')"
echo "  Disco: $(df -h / | awk 'NR==2{printf "  Usado: %s / Total: %s (%s usado)", $3,$2,$5}')"
echo ""

echo "🐳 DOCKER:"
docker ps --format "  • {{.Names}} ({{.Image}}) - {{.Status}}"
echo ""

echo "🌐 NGINX:"
if service nginx status > /dev/null 2>&1; then
    echo "  ✅ Nginx está rodando"
else
    echo "  ❌ Nginx não está rodando"
fi
echo ""

echo "🐍 PYTHON:"
source /app/venv/bin/activate
echo "  Versão: $(python --version)"
echo "  Pacotes: $(pip list | grep -E '(flask|fastapi|boto3|requests)' | wc -l) principais instalados"
echo ""

echo "💾 TIGRIS STORAGE:"
aws s3 ls --endpoint-url https://t3.storage.dev 2>/dev/null | while read -r line; do
    echo "  • $line"
done
echo ""

echo "🔗 PORTAS ABERTAS:"
echo "  • 8080  → Nginx (reverse proxy)"
echo "  • 9090  → Nginx container"
echo "  • 3000  → Node.js app"
echo "  • 5432  → PostgreSQL"
echo "  • 6379  → Redis"
echo ""

echo "════════════════════════════════════════════════"
