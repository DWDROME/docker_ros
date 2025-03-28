# ROS 2 Foxy Docker 开发环境

## 项目概述
这是一个为ROS 2 Foxy设计的Docker开发环境，包含：
- 预配置的ROS 2 Foxy开发环境
- 多机通信支持
- 常用开发工具和ROS 2包

## 文件说明

### Dockerfile
基于`osrf/ros:foxy-desktop`镜像，包含：
- ROS 2 Foxy核心包(navigation2, cartographer等)
- 开发工具(git, vim, terminator等)
- 配置了`rosuser`用户和工作目录`/ros2_ws`

### 安装脚本
- `install_docker_with_mirrors.sh`: 一键安装Docker CE并配置国内镜像源
- `setup_ros2_multi_bash.zsh`: 配置bash环境的ROS 2多机通信
- `setup_ros2_multi_zsh.sh`: 配置zsh环境的ROS 2多机通信
- `start_foxy_docker.sh`: 启动ROS 2 Foxy开发容器

## 使用步骤

1. 安装Docker:
```bash
./install_docker_with_mirrors.sh
```

2. 构建Docker镜像:
```bash
docker build -t ros2_foxy_dev .
```

3. 配置ROS 2多机通信(选择适合的shell版本):
```bash
./setup_ros2_multi_bash.zsh  # 用于bash
# 或
./setup_ros2_multi_zsh.sh    # 用于zsh
```

4. 启动开发容器:
```bash
./start_foxy_docker.sh
```

## 注意事项
1. 多机通信需要确保:
   - 所有机器使用相同的`ROS_DOMAIN_ID`
   - 网络互通且防火墙允许相关端口

2. 如需指定网卡，取消脚本中`CYCLONEDDS_INTERFACE`的注释并设置正确的网卡名称

3. 容器默认挂载主机`~/x3_ws`到容器`/ros2_ws`，可按需修改`start_foxy_docker.sh`
