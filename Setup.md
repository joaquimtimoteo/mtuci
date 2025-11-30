# MTCI Student Access & Local AI Setup

This guide provides the **correct SSH access**, system setup, and tools installation for MTCI students, including **Grafana, Prometheus, and Ollama**.

---

## ✅ Correct SSH Access

### Connect with MTCI users:

```bash
# Correct user
ssh mtci-student1@trolley.proxy.rlwy.net -p 21373
# Password: mtci123

# Other users
ssh mtci-student2@trolley.proxy.rlwy.net -p 21373
ssh mtci-student3@trolley.proxy.rlwy.net -p 21373
```

---

## 🔧 Update SSH Config (Mac)

```bash
# Create new SSH config
cat > ~/.ssh/config << 'EOF'
Host mtci1
    HostName trolley.proxy.rlwy.net
    Port 21373
    User mtci-student1
    ServerAliveInterval 30
    ServerAliveCountMax 10
    TCPKeepAlive yes

Host mtci2
    HostName trolley.proxy.rlwy.net
    Port 21373
    User mtci-student2
    ServerAliveInterval 30
    ServerAliveCountMax 10
    TCPKeepAlive yes

Host mtci3
    HostName trolley.proxy.rlwy.net
    Port 21373
    User mtci-student3
    ServerAliveInterval 30
    ServerAliveCountMax 10
    TCPKeepAlive yes
EOF

chmod 600 ~/.ssh/config

# Connect easily
ssh mtci1
# Password: mtci123
```

---

## 📊 Grafana Installation & Setup

### 1. Connect to Railway first:

```bash
ssh mtci1
# Password: mtci123
```

### 2. Install Grafana:

```bash
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
sudo systemctl status grafana-server
```

### 3. Configure Grafana:

```bash
# Grafana runs on port 3000
# On Mac: forward port
fly proxy 3000:3000 -a minha-vm-python
```

### 4. Access Grafana:

```
URL: http://localhost:3000
Login: admin
Password: admin (change on first login)
```

---

## 📈 Prometheus Installation (Monitoring)

```bash
# Create user
sudo useradd --no-create-home --shell /bin/false prometheus

# Download Prometheus
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.45.0/prometheus-2.45.0.linux-amd64.tar.gz
tar xvf prometheus-2.45.0.linux-amd64.tar.gz
cd prometheus-2.45.0.linux-amd64

# Move binaries
sudo mv prometheus /usr/local/bin/
sudo mv promtool /usr/local/bin/

# Create directories
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

# Move configs
sudo mv consoles /etc/prometheus
sudo mv console_libraries /etc/prometheus
sudo mv prometheus.yml /etc/prometheus

# Set permissions
sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus

# Create service
sudo cat > /etc/systemd/system/prometheus.service << 'EOF'
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path=/var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# Start Prometheus
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
sudo systemctl status prometheus
```

---

## 🎯 Main Commands - Cheat Sheet

```bash
# ===== CONNECTION =====
ssh mtci1
ssh mtci-student1@trolley.proxy.rlwy.net -p 21373

# ===== NAVIGATION =====
examples
myproject
workspace
ll   # List files

# ===== OLLAMA =====
ollama list
ollama run qwen2:0.5b
python3 ~/examples/chat_local.py
python3 ~/examples/test_ollama.py

# ===== PYTHON =====
python3 script.py
pip3 list
pip3 install --user PACKAGE

# ===== TMUX =====
tmux new -s work
tmux attach -t work
Ctrl+B "  # Split horizontal
Ctrl+B %  # Split vertical
Ctrl+B arrows  # Navigate panes
Ctrl+B D  # Detach

# ===== SYSTEM =====
htop
df -h
free -h
who

# ===== GRAFANA =====
sudo systemctl status grafana-server
sudo systemctl start grafana-server
sudo systemctl stop grafana-server
sudo systemctl restart grafana-server

# ===== PROMETHEUS =====
sudo systemctl status prometheus
sudo systemctl start prometheus
curl http://localhost:9090

# ===== LOGS =====
tail -f /tmp/ollama.log
sudo journalctl -u grafana-server
sudo journalctl -u prometheus

# ===== HELP =====
cat ~/COMMANDS.txt
```

---

## ✅ Quick Start

```bash
# 1. Connect
ssh mtci1
# Password: mtci123

# 2. View examples
examples
ls -la

# 3. Test Ollama
python3 chat_local.py
```

---
