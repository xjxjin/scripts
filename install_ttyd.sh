#!/bin/bash

# 安装编译所需的依赖
sudo apt-get update
sudo apt-get install -y git build-essential cmake libjson-c-dev libwebsockets-dev

# 克隆ttyd仓库
# 尝试克隆 ttyd 仓库，如果失败则尝试备选仓库
git clone https://gitee.com/xjxjin/ttyd.git 2>/dev/null
if [ $? -ne 0 ]; then
    echo "克隆 Gitee 仓库失败，尝试 GitHub 仓库..."
    git clone https://github.com/tsl0922/ttyd.git 2>/dev/null
fi
cd ttyd

# 创建构建目录并编译安装ttyd
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
ExecStart=/usr/local/bin/ttyd -p 3333 -W login

[Install]
WantedBy=multi-user.target
EOF

# 重新加载systemd管理器配置
sudo systemctl daemon-reload

# 启用并启动ttyd服务
sudo systemctl enable ttyd.service
sudo systemctl start ttyd.service

# 检查服务状态
sudo systemctl status ttyd.service
