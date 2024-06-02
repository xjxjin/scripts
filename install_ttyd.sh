#!/bin/bash

# 检查ttyd服务是否已经安装
if sudo systemctl is-enabled ttyd.service > /dev/null 2>&1; then
    echo "ttyd 服务已经安装，跳过安装步骤。"
else
    echo "安装编译所需的依赖..."
    sudo apt-get update
    sudo apt-get install -y git build-essential cmake libjson-c-dev libwebsockets-dev

    # 尝试克隆 ttyd 仓库，如果失败则尝试备选仓库
    if git clone https://gitee.com/xjxjin/ttyd.git 2>/dev/null; then
        cd ttyd
    else
        echo "克隆 Gitee 仓库失败，尝试 GitHub 仓库..."
        if git clone https://github.com/tsl0922/ttyd.git 2>/dev/null; then
            cd ttyd
        else
            echo "克隆失败，请检查网络连接或仓库地址。"
            exit 1
        fi
    fi

    # 创建构建目录并编译安装ttyd
    echo "开始编译安装ttyd..."
    mkdir build && cd build
    cmake ..
    make
    sudo make install

    # 退出build目录并删除ttyd目录
    cd ..
    rm -rf ttyd

    # 创建systemd服务文件
    cat <<EOF | sudo tee /etc/systemd/system/ttyd.service
[Unit]
Description=ttyd Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/ttyd -p 13594 -W login

[Install]
WantedBy=multi-user.target
EOF

    # 重新加载systemd管理器配置
    sudo systemctl daemon-reload

    # 启用并启动ttyd服务
    sudo systemctl enable ttyd.service
    sudo systemctl start ttyd.service

    # 获取本机的IP地址
    IP=$(hostname -I | awk '{print $1}')
    PORT=13594  # ttyd的端口号

    # 检查服务状态
    if sudo systemctl status ttyd.service | grep -q "running"; then
        echo "ttyd 服务正在运行。访问地址：http://$IP:$PORT"
    else
        echo "ttyd 服务启动失败。"
    fi
fi
