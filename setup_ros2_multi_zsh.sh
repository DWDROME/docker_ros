#!/bin/bash
# 用途：配置主机 ROS 2 多机通信环境（ZSH）

ZSHRC="$HOME/.zshrc"
BACKUP="$ZSHRC.bak.$(date +%s)"

echo "[1/3] 备份 .zshrc 到 $BACKUP..."
cp "$ZSHRC" "$BACKUP"

echo "[2/3] 写入配置到 ~/.zshrc..."
cat << 'EOF' >> "$ZSHRC"

# === ROS 2 多机通信配置 BEGIN ===
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export ROS_DOMAIN_ID=28
export ROS_AUTOMATIC_DISCOVERY_RANGE=SUBNET
unset ROS_LOCALHOST_ONLY
unset ROS_STATIC_PEERS
# export CYCLONEDDS_INTERFACE=wlo1  # 可指定网卡
# === ROS 2 多机通信配置 END ===
EOF

echo "[3/3] 立即生效配置..."
source "$ZSHRC"

echo "[✔] 主机 ROS 多机通信配置完成 ✅"
env | grep -E 'RMW_IMPL|ROS_DOMAIN_ID|DISCOVERY|LOCALHOST|STATIC'
