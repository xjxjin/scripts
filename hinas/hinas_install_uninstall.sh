#!/bin/bash

#黑色: 30m
#红色: 31m
#绿色: 32m
#黄色: 33m
#蓝色: 34m
#紫色: 35m
#青色: 36m
#白色: 37m


# 定义颜色代码
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PURPLE="\033[35m"
CYAN="\033[36m"
NC="\033[0m" # 无颜色

# 使用颜色输出的函数
print_in_color() {
    local color=$1
    local text=$2
    echo -e "${color}$text${NC}"
}



# 主菜单函数
main_menu() {
    print_in_color $PURPLE "请选择操作："
    print_in_color $CYAN "1. 安装软件"
    print_in_color $YELLOW "2. 卸载软件"
    print_in_color $RED "3. 退出脚本"
    read -p "请输入选项序号：" choice
    case $choice in
        1)
            install_menu
            ;;
        2)
            uninstall_menu
            ;;
        3)
            echo "退出脚本。"
            exit 0
            ;;
        0)
            echo "退出脚本。"
            exit 0
            ;;
        
        *)
            echo "无效的选项，请输入1、2或3。"
            main_menu
            ;;
    esac
}

# 安装菜单函数
install_menu() {
    print_in_color $BLUE "欢迎使用hinas-xiaojin安装脚本,脚本均为hinas系统内置提供"
    print_in_color $CYAN "请输入以下选项之一进行操作："
    print_in_color $RED ""
    print_in_color $RED "0. 返回上级目录"
    print_in_color $RED "all. 安装所有"
    print_in_color $CYAN "1. 安装 FileBrowser"
    print_in_color $CYAN "2. 安装 Nginx"
    print_in_color $CYAN "3. 安装 Samba (smbd)"
    print_in_color $CYAN "4. 安装 Tailscale"
    print_in_color $CYAN "5. 安装 Alist"
    print_in_color $CYAN "6. 安装 Aria2"
    print_in_color $CYAN "7. 安装 Transmission"
    print_in_color $CYAN "8. 安装 页面终端 (ttyd)"
    print_in_color $CYAN "9. 安装 KMS (vlmcsd)"
    print_in_color $CYAN "10. 安装 FRP"
    print_in_color $CYAN "11. 安装 NFS"
    print_in_color $CYAN "12. 安装 FTP (vsftpd)"
    print_in_color $CYAN "13. 安装 易有云 (linkease)"
    print_in_color $CYAN "14. 安装 typecho"
    print_in_color $CYAN "15. 安装 cronweb"
    print_in_color $CYAN "16. 安装 ddns"
    print_in_color $CYAN "17. 安装 h5ai"

    print_in_color $CYAN ""
    print_in_color $PURPLE "以下为docker安装"
    print_in_color $CYAN ""
    print_in_color $CYAN "31. 安装 青龙面板"
    print_in_color $CYAN "32. 安装 v2ray"
    print_in_color $CYAN "33. 安装 wordpress"
    print_in_color $CYAN "34. 安装 mysql"
    print_in_color $CYAN "35. 安装 chatgpt"
    print_in_color $CYAN "36. 安装 系统teslamate"
    print_in_color $CYAN "37. 安装 jellyfin"
    print_in_color $CYAN "38. 安装 casaos"
    print_in_color $CYAN "39. 安装 portainer"
    print_in_color $CYAN "40. 安装 mrdoc"
    print_in_color $CYAN "41. 安装 homebridge"
    print_in_color $CYAN "42. 安装 homeassistant"
    print_in_color $CYAN "43. 安装 kod"
    print_in_color $CYAN "44. 安装 docker"
    print_in_color $CYAN "45. 安装 justlist"
    print_in_color $CYAN "46. 安装 cloudreve"
    read -p "输入选项编号，用空格分隔（例如：1 2 3），或输入 all 安装所有，然后按回车键执行相应操作：" input
    if [[ "${input[0]}" == "all" ]]; then
        # 卸载所有
        print_in_color $YELLOW "开始 安装所有 安装。"
        for i in {1..50}; do
            install_detail $i
        done
        print_in_color $GREEN "所有安装操作已完成。"
    else
        install_detail "${input[@]}"
    fi
    install_menu


}
install_detail() {
    # 根据用户输入执行安装
    local selections=("$@")
    IFS=' ' read -r -a selected_options <<< "$selections"
    for option in "${selected_options[@]}"; do
        case $option in
            0)
                main_menu
                ;;
            1)
                print_in_color $CYAN "开始 FileBrowser 安装..."
                apt install -y filebrowser-histb 
                print_in_color $CYAN "完成 FileBrowser 安装。"
                print_in_color $CYAN ""
                ;;
            2)
                print_in_color $CYAN "开始 Nginx 安装..."
                apt install -y nginx-histb 
                print_in_color $CYAN "完成 Nginx 安装。"
                print_in_color $CYAN ""
                ;;
            3)
                print_in_color $CYAN "开始 Samba (smbd) 安装..."
                apt install -y samba-histb 
                print_in_color $CYAN "完成 Samba (smbd) 安装。"
                print_in_color $CYAN ""
                ;;
            4)
                print_in_color $CYAN "开始 Tailscale 安装..."
                apt install -y tailscale-histb 
                print_in_color $CYAN "完成 Tailscale 安装。"
                print_in_color $CYAN ""
                ;;
            5)
                print_in_color $CYAN "开始 Alist 安装..."
                apt install -y alist-histb 
                print_in_color $CYAN "完成 Alist 安装。"
                print_in_color $CYAN ""
                ;;
            6)
                print_in_color $CYAN "开始 Aria2 安装..."
                apt install -y aria2-histb 
                print_in_color $CYAN "完成 Aria2 安装。"
                print_in_color $CYAN ""
                ;;
            7)
                print_in_color $CYAN "开始 Transmission 安装..."
                apt install -y transmission-histb 
                print_in_color $CYAN "完成 Transmission 安装。"
                print_in_color $CYAN ""
                ;;
            8)
                print_in_color $CYAN "开始 页面终端 (ttyd) 安装..."
                apt install -y ttyd-histb 
                print_in_color $CYAN "完成 页面终端 (ttyd) 安装。"
                print_in_color $CYAN ""
                ;;
            9)
                print_in_color $CYAN "开始 KMS (vlmcsd) 安装..."
                apt install -y vlmcsd-histb 
                print_in_color $CYAN "完成 KMS (vlmcsd) 安装。"
                print_in_color $CYAN ""
                ;;
            10)
                print_in_color $CYAN "开始 FRP 安装..."
                apt install -y frpc-histb
                print_in_color $CYAN "完成 FRP 安装。"
                print_in_color $CYAN ""
                ;;
            11)
                print_in_color $CYAN "开始 NFS 安装..."
                apt install -y nfs-server-histb
                print_in_color $CYAN "完成 NFS 安装。"
                print_in_color $CYAN ""
                ;;
            12)
                print_in_color $CYAN "开始 FTP (vsftpd) 安装..."
                apt install -y vsftpd-histb
                print_in_color $CYAN "完成 FTP (vsftpd) 安装。"
                print_in_color $CYAN ""
                ;;
            13)
                print_in_color $CYAN "开始 易有云 (linkease) 安装..."
                apt install -y linkease-histb
                print_in_color $CYAN "完成 易有云 (linkease) 安装。"
                print_in_color $CYAN ""
                ;;

            14)
                print_in_color $CYAN "开始 typecho 安装..."
                apt install -y typecho-histb
                print_in_color $CYAN "完成 typecho 安装。"
                print_in_color $CYAN ""
                ;;
            15)
                print_in_color $CYAN "开始 cronweb 安装..."
                apt install -y cronweb-histb
                print_in_color $CYAN "完成 cronweb 安装。"
                print_in_color $CYAN ""
                ;;
            16)
                print_in_color $CYAN "开始 ddns 安装..."
                apt install -y ddns-histb
                print_in_color $CYAN "完成 ddns 安装。"
                print_in_color $CYAN ""
                ;;
            17)
                print_in_color $CYAN "开始 h5ai 安装..."
                apt install -y h5ai-histb
                print_in_color $CYAN "完成 h5ai 安装。"
                print_in_color $CYAN ""
                ;;

            31)
                print_in_color $CYAN "开始 青龙面板 安装..."
                install-qinglong.sh
                print_in_color $CYAN "完成 青龙面板 安装。"
                print_in_color $CYAN ""
                ;;
            32)
                print_in_color $CYAN "开始 v2ray 安装..."
                install-v2ray.sh
                print_in_color $CYAN "完成 v2ray 安装。"
                print_in_color $CYAN ""
                ;;
            33)
                print_in_color $CYAN "开始 wordpress 安装..."
                install-wordpress.sh 
                print_in_color $CYAN "完成 wordpress 安装。"
                print_in_color $CYAN ""
                ;;
            34)
                print_in_color $CYAN "开始 mysql 安装..."
                install-mysql.sh 
                print_in_color $CYAN "完成 mysql 安装。"
                print_in_color $CYAN ""
                ;;
            35)
                print_in_color $CYAN "开始 chatgpt 安装..."
                install-chatgpt.sh 
                print_in_color $CYAN "完成 chatgpt 安装。"
                print_in_color $CYAN ""
                ;;
            36)
                print_in_color $CYAN "开始 teslamate 安装..."
                install-teslamate1.sh  
                print_in_color $CYAN "完成 teslamate 安装。"
                print_in_color $CYAN ""
                ;;
            37)
                print_in_color $CYAN "开始 jellyfin 安装..."
                install-jellyfin.sh 
                print_in_color $CYAN "完成 jellyfin 安装。"
                print_in_color $CYAN ""
                ;;
            38)
                print_in_color $CYAN "开始 casaos 安装..."
                install-casaos.sh 
                print_in_color $CYAN "完成 casaos 安装。"
                print_in_color $CYAN ""
                ;;
            39)
                print_in_color $CYAN "开始 portainer 安装..."
                install-portainer.sh 
                print_in_color $CYAN "完成 portainer 安装。"
                print_in_color $CYAN ""
                ;;
            40)
                print_in_color $CYAN "开始 mrdoc 安装..."
                install-mrdoc.sh 
                print_in_color $CYAN "完成 mrdoc 安装。"
                print_in_color $CYAN ""
                ;;
            41)
                print_in_color $CYAN "开始 homebridge 安装..."
                install-homebridge.sh 
                print_in_color $CYAN "完成 homebridge 安装。"
                print_in_color $CYAN ""
                ;;
            42)
                print_in_color $CYAN "开始 homeassistant 安装..."
                install-homeassistant.sh 
                print_in_color $CYAN "完成 homeassistant 安装。"
                print_in_color $CYAN ""
                ;;
            43)
                print_in_color $CYAN "开始 kod 安装..."
                install-kod.sh 
                print_in_color $CYAN "完成 kod 安装。"
                print_in_color $CYAN ""
                ;;
            44)
                print_in_color $CYAN "开始 docker 安装..."
                install-docker.sh 
                print_in_color $CYAN "完成 docker 安装。"
                print_in_color $CYAN ""
                ;;
            45)
                print_in_color $CYAN "开始 justlist 安装..."
                install-justlist.sh 
                print_in_color $CYAN "完成 justlist 安装。"
                print_in_color $CYAN ""
                ;;
            46)
                print_in_color $CYAN "开始 cloudreve 安装..."
                install-cloudreve.sh 
                print_in_color $CYAN "完成 cloudreve 安装。"
                print_in_color $CYAN ""
                ;;
            *)
                print_in_color $CYAN "无效的选项 $option。"
                ;;
        esac
    done
}

# 卸载菜单函数
uninstall_menu() {
    print_in_color $BLUE "欢迎使用hinas-xiaojin卸载脚本"
    print_in_color $YELLOW "请输入以下选项之一进行操作："
    print_in_color $RED ""
    print_in_color $RED "0. 返回上级目录"
    print_in_color $RED "all. 卸载所有"
    print_in_color $YELLOW "1. 卸载 PHP"
    print_in_color $YELLOW "2. 卸载 Nginx"
    print_in_color $YELLOW "3. 卸载 Samba (smbd)"
    print_in_color $YELLOW "4. 卸载 Tailscale"
    print_in_color $YELLOW "5. 卸载 Alist"
    print_in_color $YELLOW "6. 卸载 Aria2"
    print_in_color $YELLOW "7. 卸载 Transmission"
    print_in_color $YELLOW "8. 卸载 页面终端 (ttyd)"
    print_in_color $YELLOW "9. 卸载 KMS (vlmcsd)"
    print_in_color $YELLOW "10. 卸载 FRP"
    print_in_color $YELLOW "11. 卸载 NFS"
    print_in_color $YELLOW "12. 卸载 FTP (vsftpd)"
    print_in_color $YELLOW "13. 卸载 易有云 (linkease)"
    print_in_color $YELLOW "14. 卸载 FileBrowser"
    print_in_color $YELLOW "15. 卸载 typecho"
    print_in_color $YELLOW "16. 卸载 cronweb"
    print_in_color $YELLOW "17. 卸载 ddns"
    print_in_color $YELLOW "18. 卸载 h5ai"
    print_in_color $YELLOW ""
    print_in_color $PURPLE "以下为docker卸载"
    print_in_color $YELLOW ""
    print_in_color $YELLOW "31. 卸载 青龙面板"
    print_in_color $YELLOW "32. 卸载 v2ray"
    print_in_color $YELLOW "33. 卸载 wordpress"
    print_in_color $YELLOW "34. 卸载 photoalbum"
    print_in_color $YELLOW "35. 卸载 mysql"
    print_in_color $YELLOW "36. 卸载 chatgpt"
    print_in_color $YELLOW "37. 卸载 系统teslamate"
    print_in_color $YELLOW "38. 卸载 jellyfin"
    print_in_color $YELLOW "39. 卸载 casaos"
    print_in_color $YELLOW "40. 卸载 portainer"
    print_in_color $YELLOW "41. 卸载 mrdoc"
    print_in_color $YELLOW "42. 卸载 homebridge"
    print_in_color $YELLOW "43. 卸载 homeassistant"
    print_in_color $YELLOW "44. 卸载 gitweb"
    print_in_color $YELLOW "45. 卸载 kod"
    print_in_color $YELLOW "46. 卸载 docker"
    read -p "输入选项编号，用空格分隔（例如：1 2 3），或输入 all 卸载所有，然后按回车键执行相应操作：" input
    # 根据用户输入执行卸载

    if [[ "${input[0]}" == "all" ]]; then
        # 卸载所有
        print_in_color $YELLOW "开始 卸载所有 卸载。"
        for i in {1..50}; do
            uninstall_detail $i
        done
        print_in_color $GREEN "所有卸载操作已完成。"
    else
        uninstall_detail "${input[@]}"
    fi
    uninstall_menu
}

uninstall_detail(){

    local selections=("$@")
    IFS=' ' read -r -a selected_options <<< "$selections"
    for option in "${selected_options[@]}"; do
        case $option in
            0)
                main_menu
                ;;
            all)
                # 卸载所有
                print_in_color $YELLOW "开始 卸载所有 卸载..."
                for i in {1..30}; do
                    uninstall_menu $i
                done
                print_in_color $YELLOW "所有卸载操作已完成。"
                print_in_color $YELLOW ""
                continue=false
                ;;
            1)  uninstall_cmds+=("卸载 PHP")
                # 卸载 PHP
                print_in_color $YELLOW "开始 PHP 卸载..."
                systemctl stop php*
                apt-get autoremove php7* -y
                apt purge -y php*
                find /etc -name "php" | xargs rm -rf
                find /run -name "php" | xargs rm -rf
                print_in_color $YELLOW "完成 PHP 卸载。"
                print_in_color $YELLOW ""
                ;;
            2)  uninstall_cmds+=("卸载 Nginx")
                # 卸载 Nginx
                print_in_color $YELLOW "开始 Nginx 卸载..."
                systemctl stop nginx*
                apt purge -y nginx-histb 
                apt-get --purge remove nginx -y
                apt-get --purge remove nginx-common -y
                apt-get --purge remove nginx-core -y
                rm -rf /var/www
                rm -rf /etc/first_init.d/web.sh
                rm -rf /usr/share/bak/gitweb
                rm -rf /bin/install-gitweb.sh
                print_in_color $YELLOW "完成 Nginx 卸载。"
                print_in_color $YELLOW ""
                ;;
            3)  uninstall_cmds+=("卸载 Samba (smbd)")
                # 卸载 Samba (smbd)
                print_in_color $YELLOW "开始 Samba (smbd) 卸载..."
                systemctl stop smbd*
                apt-get remove --purge samba -y
                apt purge -y samba-histb
                apt purge -y samba-common
                apt purge -y samba-dsdb-modules 
                apt purge -y samba-vfs-modules 
                find /etc -name "samba" | xargs rm -rf
                find /var -name "samba" | xargs rm -rf
                find /run -name "samba" | xargs rm -rf
                rm -rf /usr/share/samba
                print_in_color $YELLOW "完成 Samba (smbd) 卸载。"
                print_in_color $YELLOW ""
                ;;
            4)  uninstall_cmds+=("卸载 Tailscale")
                # 卸载 Tailscale
                print_in_color $YELLOW "开始 Tailscale 卸载..."
                systemctl stop tailscale*
                apt purge -y tailscale-hist
                rm -rf /opt/tailscale
                find / -name "tailscale*" | xargs rm -rf
                print_in_color $YELLOW "完成 Tailscale 卸载。"
                print_in_color $YELLOW ""
                ;;
            5)  uninstall_cmds+=("卸载 Alist")
                # 卸载 Alist
                print_in_color $YELLOW "开始 Alist 卸载..."
                systemctl stop alist*
                apt purge -y alist-histb
                rm -rf /opt/alist
                find /etc -name "alist.service" | xargs rm -rf
                print_in_color $YELLOW "完成 Alist 卸载。"
                print_in_color $YELLOW ""
                ;;
            6)  uninstall_cmds+=("卸载 Aria2")
                # 卸载 Aria2
                print_in_color $YELLOW "开始 Aria2 卸载..."
                systemctl stop aria*
                apt purge -y aria2-histb 
                rm -rf /usr/bin/aria2c
                rm -rf /usr/local/aria2
                find /etc -name "aria2c.service" | xargs rm -rf
                print_in_color $YELLOW "完成 Aria2 卸载。"
                print_in_color $YELLOW ""
                ;;
            7)  uninstall_cmds+=("卸载 Transmission")
                # 卸载 Transmission
                print_in_color $YELLOW "开始 Transmission 卸载..."
                systemctl stop transmission*
                apt-get --purge remove transmission-* -y
                apt purge -y transmission-histb 
                apt purge -y transmission-common
                rm -rf /usr/share/transmission
                print_in_color $YELLOW "完成 Transmission 卸载。"
                print_in_color $YELLOW ""
                ;;
            8)  uninstall_cmds+=("卸载 页面终端 (ttyd)")
                # 卸载 页面终端 (ttyd)
                print_in_color $YELLOW "开始 页面终端 (ttyd) 卸载..."
                systemctl stop ttyd.service
                apt purge -y ttyd-histb 
                rm -rf /usr/bin/ttyd
                find /etc -name "ttyd.service" | xargs rm -rf
                print_in_color $YELLOW "完成 页面终端 (ttyd) 卸载。"
                print_in_color $YELLOW ""
                ;;
            9)  uninstall_cmds+=("卸载 KMS (vlmcsd)")
                # 卸载 KMS (vlmcsd)
                print_in_color $YELLOW "开始 KMS (vlmcsd) 卸载..."
                systemctl stop vlmcsd
                apt purge -y vlmcsd-histb 
                rm -rf /usr/bin/vlmcsd
                find /etc -name "vlmcsd*" | xargs rm -rf
                print_in_color $YELLOW "完成 KMS (vlmcsd) 卸载。"
                print_in_color $YELLOW ""
                ;;
            10)  uninstall_cmds+=("卸载 FRP")
                # 卸载 FRP
                print_in_color $YELLOW "开始 FRP 卸载..."
                systemctl stop frpc.service
                apt purge -y frpc-histb 
                rm -rf /etc/first_init.d/frpc.sh
                rm -rf /etc/frp
                rm -rf /usr/bin/frpc
                rm -rf /etc/systemd/system/frpc.service
                print_in_color $YELLOW "完成 FRP 卸载。"
                print_in_color $YELLOW ""
                ;;
            11)  uninstall_cmds+=("卸载 NFS")
                # 卸载 NFS
                print_in_color $YELLOW "开始 NFS 卸载..."
                apt purge -y nfs-server-histb 
                apt-get --purge remove nfs-* -y
                print_in_color $YELLOW "完成 NFS 卸载。"
                ;;
            12)  uninstall_cmds+=("卸载 FTP (vsftpd)")
                # 卸载 FTP (vsftpd)
                print_in_color $YELLOW "开始 FTP (vsftpd) 卸载..."
                systemctl stop vsftpd
                apt-get --purge remove vsftpd -y
                apt purge -y vsftpd-histb 
                apt purge -y vsftpd 
                find /run -name "vsftpd" | xargs rm -rf
                print_in_color $YELLOW "完成 FTP (vsftpd) 卸载。"
                print_in_color $YELLOW ""
                ;;
            13)  uninstall_cmds+=("卸载 易有云 (linkease)")
                # 卸载 易有云 (linkease)
                print_in_color $YELLOW "开始 易有云 (linkease) 卸载..."
                sudo systemctl stop linkease.service
                apt purge -y linkease-histb
                apt remove linkease
                sudo rm /usr/local/bin/linkease
                sudo rm -rf /usr/local/linkease
                print_in_color $YELLOW "完成 易有云 (linkease) 卸载。"
                print_in_color $YELLOW ""
                ;;
            14)  uninstall_cmds+=("卸载 FileBrowser")
                # 卸载 FileBrowser
                print_in_color $YELLOW "开始 FileBrowser 卸载..."
                sudo systemctl stop filebrowser
                sudo systemctl disable filebrowser.service
                apt purge -y filebrowser-histb 
                sudo find / -type f -name "*filebrowser*" ! -name "*.deb" ! -name "*.rpm" -exec rm -f {} \; 2>/dev/null
                sudo find / -type f -name "*filebrowser*" ! -name "*.deb" ! -name "*.rpm" -exec rm -rf {} \; 2>/dev/null
                sudo rm -rf /opt/filebrowser
                print_in_color $YELLOW "完成 FileBrowser 卸载。"
                print_in_color $YELLOW ""
                ;;


            15)  uninstall_cmds+=("卸载 typecho")
                # 卸载 FileBrowser
                print_in_color $YELLOW "开始 typecho 卸载..."
                sudo systemctl stop typecho                
                apt purge -y typecho-histb
                print_in_color $YELLOW "完成 typecho 卸载。"
                print_in_color $YELLOW ""
                ;;
            16)  uninstall_cmds+=("卸载 cronweb")
                # 卸载 FileBrowser
                print_in_color $YELLOW "开始 cronweb 卸载..."
                sudo systemctl stop cronweb                
                apt purge -y cronweb-histb 
                print_in_color $YELLOW "完成 cronweb 卸载。"
                print_in_color $YELLOW ""
                ;;
            17)  uninstall_cmds+=("卸载 ddns")
                # 卸载 FileBrowser
                print_in_color $YELLOW "开始 ddns 卸载..."
                sudo systemctl stop ddns                
                apt purge -y ddns-histb 
                print_in_color $YELLOW "完成 ddns 卸载。"
                print_in_color $YELLOW ""
                ;;

            18)  uninstall_cmds+=("卸载 h5ai")
                # 卸载 FileBrowser
                print_in_color $YELLOW "开始 h5ai 卸载..."
                sudo systemctl stop h5ai                
                apt purge -y h5ai-histb 
                print_in_color $YELLOW "完成 h5ai 卸载。"
                print_in_color $YELLOW ""
                ;;



            31)  uninstall_cmds+=("卸载 青龙面板")
                # 卸载 青龙面板
                print_in_color $YELLOW "开始 青龙面板 卸载..."
                hinas-clear qinglong
                print_in_color $YELLOW "完成 青龙面板 卸载。"
                print_in_color $YELLOW ""
                ;;
            32)  uninstall_cmds+=("卸载 v2ray")
                # 卸载 v2ray
                print_in_color $YELLOW "开始 v2ray 卸载..."
                hinas-clear v2ray
                print_in_color $YELLOW "完成 v2ray 卸载。"
                print_in_color $YELLOW ""
                ;;
            33)  uninstall_cmds+=("卸载 wordpress")
                # 卸载 wordpress
                print_in_color $YELLOW "开始 wordpress 卸载..."
                hinas-clear wordpress
                print_in_color $YELLOW "完成 wordpress 卸载。"
                print_in_color $YELLOW ""
                ;;
            34)  uninstall_cmds+=("卸载 photoalbum")
                # 卸载 photoalbum
                print_in_color $YELLOW "开始 photoalbum 卸载..."
                hinas-clear photoalbum
                print_in_color $YELLOW "完成 photoalbum 卸载。"
                print_in_color $YELLOW ""
                ;;
            35)  uninstall_cmds+=("卸载 mysql")
                # 卸载 mysql
                print_in_color $YELLOW "开始 mysql 卸载..."
                hinas-clear mysql
                print_in_color $YELLOW "完成 mysql 卸载。"
                print_in_color $YELLOW ""
                ;;
            36)  uninstall_cmds+=("卸载 chatgpt")
                # 卸载 chatgpt
                print_in_color $YELLOW "开始 chatgpt 卸载..."
                hinas-clear chatgpt
                print_in_color $YELLOW "完成 chatgpt 卸载。"
                print_in_color $YELLOW ""
                ;;
            37)  uninstall_cmds+=("卸载 系统teslamate")
                # 卸载 系统teslamate
                print_in_color $YELLOW "开始 系统teslamate 卸载..."
                hinas-clear teslamate
                print_in_color $YELLOW "完成 系统teslamate 卸载。"
                print_in_color $YELLOW ""
                ;;
            38)  uninstall_cmds+=("卸载 jellyfin")
                # 卸载 jellyfin
                print_in_color $YELLOW "开始 jellyfin 卸载..."
                hinas-clear jellyfin
                print_in_color $YELLOW "完成 jellyfin 卸载。"
                print_in_color $YELLOW ""
                ;;
            39)  uninstall_cmds+=("卸载 casaos")
                # 卸载 casaos
                print_in_color $YELLOW "开始 casaos 卸载..."
                hinas-clear casaos
                print_in_color $YELLOW "完成 casaos 卸载。"
                print_in_color $YELLOW ""
                ;;
            40)  uninstall_cmds+=("卸载 portainer")
                # 卸载 portainer
                print_in_color $YELLOW "开始 portainer 卸载..."
                hinas-clear portainer
                print_in_color $YELLOW "完成 portainer 卸载。"
                print_in_color $YELLOW ""
                ;;
            41)  uninstall_cmds+=("卸载 mrdoc")
                # 卸载 mrdoc
                print_in_color $YELLOW "开始 mrdoc 卸载..."
                hinas-clear mrdoc
                print_in_color $YELLOW "完成 mrdoc 卸载。"
                print_in_color $YELLOW ""
                ;;
            42)  uninstall_cmds+=("卸载 homebridge")
                # 卸载 青龙面板
                print_in_color $YELLOW "开始 homebridge 卸载..."
                hinas-clear homebridge
                print_in_color $YELLOW "完成 homebridge 卸载。"
                print_in_color $YELLOW ""
                ;;
            43)  uninstall_cmds+=("卸载 homeassistant")
                # 卸载 homeassistant
                print_in_color $YELLOW "开始 homeassistant 卸载..."
                hinas-clear homeassistant
                print_in_color $YELLOW "完成 homeassistant 卸载。"
                print_in_color $YELLOW ""
                ;;
            44)  uninstall_cmds+=("卸载 gitweb")
                # 卸载 gitweb
                print_in_color $YELLOW "开始 gitweb 卸载..."
                hinas-clear gitweb
                print_in_color $YELLOW "完成 gitweb 卸载。"
                print_in_color $YELLOW ""
                ;;
            45)  uninstall_cmds+=("卸载 kod")
                # 卸载 kod
                print_in_color $YELLOW "开始 kod 卸载..."
                hinas-clear kod
                print_in_color $YELLOW "完成 kod 卸载。"
                print_in_color $YELLOW ""
                ;;
            46)  uninstall_cmds+=("卸载 docker")
                # 卸载 docker
                print_in_color $YELLOW "开始 docker 卸载..."
                hinas-clear docker
                print_in_color $YELLOW "完成 docker 卸载。"
                print_in_color $YELLOW ""
                ;;
            *)
                print_in_color $YELLOW "无效的选项 $option。"
                ;;
        esac
    done
}

# 运行主菜单
main_menu
