#!/bin/bash
# 功能：在 Ubuntu 上一键安装 Docker CE，并配置国内镜像加速源

set -e

echo "[1/6] 添加 keyrings..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "[2/6] 添加 Docker 软件源..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[3/6] 更新 apt 索引..."
sudo apt update

echo "[4/6] 安装 Docker CE..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[5/6] 配置加速镜像..."
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json > /dev/null <<-'EOF'
{
  "registry-mirrors": [
    "https://docker.mirrors.ustc.edu.cn",
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com"
  ]
}
EOF

echo "[6/6] 启动 Docker 服务..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart docker

echo "[✔] Docker 安装完成，版本信息如下："
docker --version

echo "[✔] 正在测试拉取 hello-world..."
docker pull hello-world

echo "[✔] 所有步骤完成，可开始使用 Docker。"
