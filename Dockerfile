# 基础镜像
FROM osrf/ros:foxy-desktop

# 环境变量
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

# 更新源并安装常用工具与开发依赖
RUN apt update && apt upgrade -y && \
    apt install -y \
    git curl wget vim sudo locales tmux bash-completion \
    net-tools iputils-ping lsb-release \
    python3-pip python3-colcon-common-extensions python3-vcstool \
    terminator neofetch htop ranger \
    ros-foxy-navigation2 ros-foxy-nav2-bringup \
    ros-foxy-cartographer ros-foxy-cartographer-ros \
    ros-foxy-xacro ros-foxy-rviz2 ros-foxy-gazebo-ros-pkgs \
    code && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    useradd -m -s /bin/bash rosuser && \
    echo "rosuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir -p /ros2_ws/src && \
    chown -R rosuser:rosuser /ros2_ws

# 默认工作目录
WORKDIR /ros2_ws

# 设置默认用户
USER rosuser

# 启动终端时显示系统信息
RUN echo 'neofetch' >> /home/rosuser/.bashrc
