#!/bin/bash

# 定义颜色代码
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
NC="\033[0m" # No Color - 重置颜色


# 定义变量
DOWNLOAD_URL="https://gitee.com/xjxjin/hinas/raw/master/hi3798mv100_hinas_wifi.tar.gz"
EXTRACT_PATH="/tmp_bak/hi3798mv100_hinas_wifi"

# 函数：下载文件
download_file() {
    echo "开始下载文件..."
    mkdir -p "/tmp_bak"
    wget -O "/tmp_bak/$(basename $DOWNLOAD_URL)" "$DOWNLOAD_URL"
}

# 函数：解压文件
extract_file() {
    echo "解压文件到 /tmp_bak ..."
    mkdir -p "$EXTRACT_PATH"
    tar -xzf "/tmp_bak/$(basename $DOWNLOAD_URL)" -C "$EXTRACT_PATH" --strip-components=1
}

# 函数：执行dd命令
execute_dd_command() {
    local kernel_file="$EXTRACT_PATH/hi_kernel-mv100-0808.bin"
    echo "写入内核到 /dev/mmcblk0p6 ..."
    dd if="$kernel_file" of=/dev/mmcblk0p6
}

# 函数：重启服务器
reboot_server() {
    read -p "内核写入完成，是否重启服务器？(y/n): " REBOOT
    if [[ $REBOOT == [Yy] ]]; then
        echo "重启服务器..."
        reboot
    else
        echo "重启已取消。"
        exit 1
    fi
}

# 函数：执行wifi安装脚本
# execute_wifi_install() {
#     local install_script="$EXTRACT_PATH/wifi_install.sh"
#     echo "执行wifi安装脚本..."
#     sh "$install_script" -f "$EXTRACT_PATH/rtl8188etv-0808.tar.gz"
# }

execute_wifi_install() {
    local install_script="$EXTRACT_PATH/wifi_install.sh"
    local module_file

    # 显示输入窗口并获取用户输入
    echo "请选择要执行的网卡类型:"
    echo " etv - 执行 rtl8188etv-0808.tar.gz 安装"
    echo " ftv - 执行 rtl8188ftv-0808.tar.gz 安装"
    read -p "请输入选项 (默认为 ftv): " user_choice

    # 根据用户输入设置模块文件名
    case $user_choice in
        etv)
            module_file="rtl8188etv-0808.tar.gz"
            ;;
        *)
            # 默认选项或无效输入
            module_file="rtl8188ftv-0808.tar.gz"
            ;;
    esac

    echo "执行wifi安装脚本..."
    echo "sh $install_script" -f "$EXTRACT_PATH/$module_file"
    sh "$install_script" -f "$EXTRACT_PATH/$module_file"
}


# 函数：连接wifi并打印提示信息
connect_wifi_and_print_info() {
    # 打印带颜色的文本
    echo -e "连接wifi: ${GREEN}nmcli device wifi connect \"WiFi名字\" password \"WiFi密码\" ifname wlan0${NC}"
    echo -e "查看wifi连接状态: ${GREEN}nmcli device status${NC}"
    # 以下两行是示例用法，实际使用时需要替换为具体的WiFi名字和密码
    # nmcli device wifi connect "$wifi_ssid" password "$wifi_password" ifname wlan0
    # nmcli device status
}



# 函数：清理临时文件
cleanup() {
    read -p "wifi安装完成，是否清理临时文件？(y/n): " REBOOT
    if [[ $REBOOT == [Yy] ]]; then
        echo "清理临时文件..."
        echo "$EXTRACT_PATH*"
        rm -rf "$EXTRACT_PATH"*
    else
        echo "清理临时文件已取消。"
        exit 1
    fi
}

# 主逻辑
main() {
    # 检查是否需要重新执行步骤1-4
    if [ ! -f "$EXTRACT_PATH/hi_kernel-mv100-0808.bin" ]; then
        download_file
        extract_file
        execute_dd_command
        reboot_server
    fi

    # 重启后执行步骤5和6
    execute_wifi_install
    connect_wifi_and_print_info

    # 执行完毕后清理
    cleanup
}

# 调用主函数
main
