#!/bin/bash
## Author: SuperManito
## Modified: 2024-01-31
## License: MIT
## GitHub: https://github.com/SuperManito/LinuxMirrors
## Website: https://linuxmirrors.cn

## Docker Registry 镜像仓库列表
# 格式："软件源名称@软件源地址"
mirror_list_registry=(
    #"上海交通大学@docker.mirrors.sjtug.sjtu.edu.cn"
    #"网易@hub-mirror.c.163.com"
    #"腾讯云@mirror.ccs.tencentyun.com"
    #"道客-DaoCloud@f1361db2.m.daocloud.io"
    #"微软-Azure（中国）@dockerhub.azk8s.cn"
    #"阿里云（杭州）@registry.cn-hangzhou.aliyuncs.com"
    #"阿里云（上海）@registry.cn-shanghai.aliyuncs.com"
    #"阿里云（青岛）@registry.cn-qingdao.aliyuncs.com"
    #"阿里云（北京）@registry.cn-beijing.aliyuncs.com"
    #"阿里云（张家口）@registry.cn-zhangjiakou.aliyuncs.com"
    #"阿里云（呼和浩特）@registry.cn-huhehaote.aliyuncs.com"
    #"阿里云（乌兰察布）@registry.cn-wulanchabu.aliyuncs.com"
    #"阿里云（深圳）@registry.cn-shenzhen.aliyuncs.com"
    #"阿里云（河源）@registry.cn-heyuan.aliyuncs.com"
    #"阿里云（广州）@registry.cn-guangzhou.aliyuncs.com"
    #"阿里云（成都）@registry.cn-chengdu.aliyuncs.com"
    #"阿里云（香港）@registry.cn-hongkong.aliyuncs.com"
    #"阿里云（日本-东京）@registry.ap-northeast-1.aliyuncs.com"
    #"阿里云（新加坡）@registry.ap-southeast-1.aliyuncs.com"
    #"阿里云（澳大利亚-悉尼）@registry.ap-southeast-2.aliyuncs.com"
    #"阿里云（马来西亚-吉隆坡）@registry.ap-southeast-3.aliyuncs.com"
    #"阿里云（印度尼西亚-雅加达）@registry.ap-southeast-5.aliyuncs.com"
    #"阿里云（印度-孟买）@registry.ap-south-1.aliyuncs.com"
    #"阿里云（德国-法兰克福）@registry.eu-central-1.aliyuncs.com"
    #"阿里云（英国-伦敦）@registry.eu-west-1.aliyuncs.com"
    #"阿里云（美国西部-硅谷）@registry.us-west-1.aliyuncs.com"
    #"阿里云（美国东部-弗吉尼亚）@registry.us-east-1.aliyuncs.com"
    #"阿里云（阿联酋-迪拜）@registry.me-east-1.aliyuncs.com"
    #"阿里云（hinas海纳斯）@z0nkeoyx.mirror.aliyuncs.com"
    #"谷歌云@mirror.gcr.io"
    #"官方@registry.hub.docker.com"
    "uuuadc@hub.uuuadc.top"
    "1panel@docker.1panel.live"
    "rat@hub.rat.dev"
    "anyhub@docker.anyhub.us.kg"
    "chenby@docker.chenby.cn"
    "jobcher@dockerhub.jobcher.com"
    "dockerhub@dockerhub.icu"
    "ckyl@docker.ckyl.me"
    "awsl9527@docker.awsl9527.cn"
    "hpcloud@docker.hpcloud.cloud"
    "nastool@docker.nastool.de"
    "daocloud@docker.m.daocloud.io"
    "aidenxin@docker.aidenxin.xyz"
)

## 定义拉取的镜像,使用一个很小的镜像来测试速度
IMAGE="xjxjin/alist-sync"

## 定义系统判定变量
SYSTEM_DEBIAN="Debian"
SYSTEM_UBUNTU="Ubuntu"
SYSTEM_KALI="Kali"
SYSTEM_REDHAT="RedHat"
SYSTEM_RHEL="RedHat"
SYSTEM_CENTOS="CentOS"
SYSTEM_CENTOS_STREAM="CentOS Stream"
SYSTEM_ROCKY="Rocky"
SYSTEM_ALMALINUX="AlmaLinux"
SYSTEM_FEDORA="Fedora"
SYSTEM_OPENCLOUDOS="OpenCloudOS"
SYSTEM_OPENEULER="openEuler"

## 定义目录和文件
File_LinuxRelease=/etc/os-release
File_RedHatRelease=/etc/redhat-release
File_OpenCloudOSRelease=/etc/opencloudos-release
File_openEulerRelease=/etc/openEuler-release
File_DebianVersion=/etc/debian_version
File_DebianSourceList=/etc/apt/sources.list
Dir_DebianExtendSource=/etc/apt/sources.list.d
Dir_YumRepos=/etc/yum.repos.d

## 定义 Docker 相关变量
DockerDir=/etc/docker
DockerConfig=$DockerDir/daemon.json
DockerConfigBackup=$DockerDir/daemon.json.bak
DockerVersionFile=docker-version.txt
DockerCEVersionFile=docker-ce-version.txt
DockerCECLIVersionFile=docker-ce-cli-version.txt

## 定义颜色变量
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
PLAIN='\033[0m'
BOLD='\033[1m'
SUCCESS='[\033[32mOK\033[0m]'
COMPLETE='[\033[32mDONE\033[0m]'
WARN='[\033[33mWARN\033[0m]'
ERROR='[\033[31mERROR\033[0m]'
WORKING='[\033[34m*\033[0m]'

function StartTitle() {
    [[ -z "${SOURCE}" || -z "${SOURCE_REGISTRY}" ]] && clear
    # echo -e ' +-----------------------------------+'
    # echo -e " | \033[0;1;35;95m⡇\033[0m  \033[0;1;33;93m⠄\033[0m \033[0;1;32;92m⣀⡀\033[0m \033[0;1;36;96m⡀\033[0;1;34;94m⢀\033[0m \033[0;1;35;95m⡀⢀\033[0m \033[0;1;31;91m⡷\033[0;1;33;93m⢾\033[0m \033[0;1;32;92m⠄\033[0m \033[0;1;36;96m⡀⣀\033[0m \033[0;1;34;94m⡀\033[0;1;35;95m⣀\033[0m \033[0;1;31;91m⢀⡀\033[0m \033[0;1;33;93m⡀\033[0;1;32;92m⣀\033[0m \033[0;1;36;96m⢀⣀\033[0m |"
    # echo -e " | \033[0;1;31;91m⠧\033[0;1;33;93m⠤\033[0m \033[0;1;32;92m⠇\033[0m \033[0;1;36;96m⠇⠸\033[0m \033[0;1;34;94m⠣\033[0;1;35;95m⠼\033[0m \033[0;1;31;91m⠜⠣\033[0m \033[0;1;33;93m⠇\033[0;1;32;92m⠸\033[0m \033[0;1;36;96m⠇\033[0m \033[0;1;34;94m⠏\033[0m  \033[0;1;35;95m⠏\033[0m  \033[0;1;33;93m⠣⠜\033[0m \033[0;1;32;92m⠏\033[0m  \033[0;1;34;94m⠭⠕\033[0m |"
    # echo -e ' +-----------------------------------+'
    text_art=$(cat <<'EOF'
                                   ..
                                  ....                       
                               .:----=:                      
                      ...:::---==-:::-+.                     
                  ..:=====-=+=-::::::==               .:-.   
              .-==*=-:::::::::::::::=*-:           .:-=++.   
           .-==++++-::::::::::::::-++:-==:.       .=-=::=-.  
   ....:::-=-::-++-:::::::::::::::--:::::==:      -:.:=..+:  
  ==-------::::-==-:::::::::::::::::::::::-+-.  .=:   .:=-.. 
  ==-::::+-:::::==-:::::::::::::::::::::::::=+.:+-    :-:    
   :--==+*::::::-=-::::::::::::::::::::::::::-*+:    .+.     
      ..-*:::::::==::::::::::::::::::::::::::-+.     -+.     
        -*:::::::-=-:::::::--:::::::::::::::=-.      +-      
        :*::::::::-=::::::-=:::::=:::::::::-:       .*.      
        .+=:::::::::::::::-::::-*-::......::        --       
         :+::-:::::::::::::::::*=:-::......         -.       
          :-:-===-:::::::::::.:+==--:......        .+.       
        .==:...-+#+::.......   .   .......         .=-       
        -*.....::............::-.                 ...=-      
        .==-:..       :=-::::::=.                  ..:+-     
          .:--===---=-:::-:::--:.                   ..:+:    
             =--+=:+*+:. ......                      ..-+.   
            .#. .+#- .:.                             .::=:   
             -=:.-:                                  ..::-.  
              .-=.               xjxjin              ...:-:  
               ...                                    ...:-  

EOF
    )

    echo "$text_art"
    echo -e '  欢迎使用 Docker Engine 一键安装脚本'
}

## 报错退出
function Output_Error() {
    [ "$1" ] && echo -e "\n$ERROR $1\n"
    exit 1
}

## 基础环境判断
function PermissionJudgment() {
    if [ $UID -ne 0 ]; then
        echo -e "\n$ERROR 权限不足，请使用 Root 用户运行本脚本\n"
        exit 1
    fi
}

## 检查Docker是否安装
function CheckInstallDocker() {
    if ! docker --version &> /dev/null; then
        echo -e "\n$ERROR docker 未安装，请先安装docker\n"
        exit 1
    fi
}

## 系统判定变量
function EnvJudgment() {
    ## 定义系统名称
    SYSTEM_NAME="$(cat $File_LinuxRelease | grep -E "^NAME=" | awk -F '=' '{print$2}' | sed "s/[\'\"]//g")"
    cat $File_LinuxRelease | grep "PRETTY_NAME=" -q
    [ $? -eq 0 ] && SYSTEM_PRETTY_NAME="$(cat $File_LinuxRelease | grep -E "^PRETTY_NAME=" | awk -F '=' '{print$2}' | sed "s/[\'\"]//g")"
    ## 定义系统版本号
    SYSTEM_VERSION_NUMBER="$(cat $File_LinuxRelease | grep -E "^VERSION_ID=" | awk -F '=' '{print$2}' | sed "s/[\'\"]//g")"
    ## 定义系统ID
    SYSTEM_ID="$(cat $File_LinuxRelease | grep -E "^ID=" | awk -F '=' '{print$2}' | sed "s/[\'\"]//g")"
    ## 判定当前系统派系
    if [ -s $File_DebianVersion ]; then
        SYSTEM_FACTIONS="${SYSTEM_DEBIAN}"
    elif [ -s $File_openEulerRelease ]; then
        SYSTEM_FACTIONS="${SYSTEM_OPENEULER}"
    elif [ -s $File_RedHatRelease ]; then
        SYSTEM_FACTIONS="${SYSTEM_REDHAT}"
    elif [ -s $File_OpenCloudOSRelease ]; then
        SYSTEM_FACTIONS="${SYSTEM_OPENCLOUDOS}" # 注：RedHat 判断优先级需要高于 OpenCloudOS，因为8版本基于红帽而9版本不是
    else
        Output_Error "无法判断当前运行环境，当前系统不在本脚本的支持范围内"
    fi
    ## 判定系统名称、版本、版本号
    case "${SYSTEM_FACTIONS}" in
    "${SYSTEM_DEBIAN}")
        if [ ! -x /usr/bin/lsb_release ]; then
            apt-get install -y lsb-release
            if [ $? -ne 0 ]; then
                Output_Error "lsb-release 软件包安装失败\n        本脚本需要通过 lsb_release 指令判断系统具体类型和版本，当前系统可能为精简安装，请自行安装后重新执行脚本！"
            fi
        fi
        SYSTEM_JUDGMENT="$(lsb_release -is)"
        SYSTEM_VERSION_CODENAME="${DEBIAN_CODENAME:-"$(lsb_release -cs)"}"
        ;;
    "${SYSTEM_REDHAT}")
        SYSTEM_JUDGMENT="$(cat $File_RedHatRelease | awk -F ' ' '{printf$1}')"
        ## Red Hat Enterprise Linux
        cat $File_RedHatRelease | grep -q "${SYSTEM_RHEL}"
        [ $? -eq 0 ] && SYSTEM_JUDGMENT="${SYSTEM_RHEL}"
        ## CentOS Stream
        cat $File_RedHatRelease | grep -q "${SYSTEM_CENTOS_STREAM}"
        [ $? -eq 0 ] && SYSTEM_JUDGMENT="${SYSTEM_CENTOS_STREAM}"
        ;;
    "${SYSTEM_OPENCLOUDOS}")
        SYSTEM_JUDGMENT="${SYSTEM_OPENCLOUDOS}"
        ;;
    "${SYSTEM_OPENEULER}")
        SYSTEM_JUDGMENT="${SYSTEM_OPENEULER}"
        ;;
    esac
    ## 判定系统处理器架构
    case $(uname -m) in
    x86_64)
        SYSTEM_ARCH="x86_64"
        SOURCE_ARCH="amd64"
        ;;
    aarch64)
        SYSTEM_ARCH="ARM64"
        SOURCE_ARCH="arm64"
        ;;
    armv7l)
        SYSTEM_ARCH="ARMv7"
        SOURCE_ARCH="armhf"
        ;;
    armv6l)
        SYSTEM_ARCH="ARMv6"
        SOURCE_ARCH="armhf"
        ;;
    i386 | i686)
        Output_Error "Docker Engine 不支持安装在 x86_32 架构的环境上！"
        ;;
    *)
        SYSTEM_ARCH=$(uname -m)
        SOURCE_ARCH=armhf
        ;;
    esac
    ## 定义软件源分支名称
    case "${SYSTEM_JUDGMENT}" in
    "${SYSTEM_CENTOS}" | "${SYSTEM_DEBIAN}" | "${SYSTEM_UBUNTU}" | "${SYSTEM_FEDORA}")
        SOURCE_BRANCH="$(echo "${SYSTEM_JUDGMENT,,}" | sed "s/ /-/g")"
        ;;
    "${SYSTEM_CENTOS_STREAM}" | "${SYSTEM_ALMALINUX}" | "${SYSTEM_ROCKY}" | "${SYSTEM_OPENCLOUDOS}" | "${SYSTEM_OPENEULER}")
        SOURCE_BRANCH="centos"
        ;;
    "${SYSTEM_RHEL}")
        SOURCE_BRANCH="rhel"
        ;;
    "${SYSTEM_KALI}")
        # Kali 使用 Debian 12 的 docker ce 源
        SOURCE_BRANCH="debian"
        SYSTEM_VERSION_CODENAME="bullseye"
        ;;
    *)
        Output_Error "当前系统不在本脚本的支持范围内"
        ;;
    esac
    ## 定义软件源更新文字
    case "${SYSTEM_FACTIONS}" in
    "${SYSTEM_DEBIAN}")
        SYNC_MIRROR_TEXT="更新软件源"
        ;;
    "${SYSTEM_REDHAT}" | "${SYSTEM_OPENCLOUDOS}" | "${SYSTEM_OPENEULER}")
        SYNC_MIRROR_TEXT="生成软件源缓存"
        ;;
    esac
}

# 检查是否安装了bc，如果没有安装，则进行安装
CheckBc() {
    if ! command -v bc &> /dev/null; then
        echo "找不到bc，正在尝试安装它。。。"
        sudo apt-get update
        if ! sudo apt-get install -y bc; then
            echo "Failed to install bc. Please install it manually and rerun the script."
            exit 1
        fi
    fi
}

# 定义一个函数来测试镜像源的下载速度
test_speed() {
    local source=$1
    # local image="xjxjin/alist-sync" # 使用一个很小的镜像来测试速度
    # 拉取镜像前记录当前时间
    SECONDS=0

    # 使用指定的镜像源拉取xjxjin/alist-sync镜像
    docker rmi $source/$IMAGE > /dev/null 2>&1
    #timeout 300 docker pull $source/$IMAGE > /dev/null 2>&1
    docker pull $source/$IMAGE > /dev/null 2>&1
    local status=$?
    if [ $status -eq 124 ]; then
        # 超时错误
        # echo "Docker pull timed out, exit status: $status"
        docker rmi "$source/$image" > /dev/null 2>&1
        echo "300"
        return
    elif [ $status -ne 0 ]; then
        # 其他错误
        # echo "Docker pull failed, exit status: $status"
        docker rmi "$source/$image" > /dev/null 2>&1
        echo "300"
        return
    fi
    docker rmi $source/$IMAGE > /dev/null 2>&1

    # 计算下载时间（秒）
    echo $SECONDS
}


# 定义一个函数，用于等待一个进程在给定的时间内完成，否则返回超时  
# wait_timeout() {  
#     local pid=$1  
#     local timeout=$2  
#     local kill_signal=TERM  # 默认发送TERM信号  
  
#     # 使用timeout命令等待子进程结束，或者超时后发送信号  
#     timeout $timeout bash -c "while kill -0 $pid 2>/dev/null; do sleep 1; done" || kill -$kill_signal $pid  
#     wait $pid 2>/dev/null  # 等待进程真正结束，忽略任何错误  
#     return $?  # 返回子进程的退出状态  
# }  

# 定义一个函数来测试镜像源的下载速度	
# test_speed() {  
#     local source=$1  
#     local image="xjxjin/alist-sync:1.0.1"  
#     local start_time  
#     local timeout_seconds=30  
  
#     # 拉取镜像前记录当前时间  
#     start_time=$(date +%s.%N)  
  
#     # 将docker pull放入后台运行  
#     docker pull "$source/$image" > /dev/null 2>&1 &  
#     local pull_pid=$!  # 获取后台进程的PID  
  
#     # 等待docker pull完成或者超时  
#     if ! wait_timeout $pull_pid $timeout_seconds; then  
#         # 如果超时，则设置download_time为30秒（作为超时指示）  
#         local download_time=30  
#         echo "下载超时"  
#     else  
#         # 拉取镜像后记录当前时间  
#         local end_time=$(date +%s.%N)  
  
#         # 计算下载时间（秒）  
#         local download_time=$(echo "$end_time - $start_time" | bc -l)  
#     fi  
  
#     echo "$download_time"  
# }  



function ChooseMirrors() {
    ## 打印软件源列表
    function PrintMirrorsList() {
        local tmp_mirror_name tmp_mirror_url arr_num default_mirror_name_length tmp_mirror_name_length tmp_spaces_nums a i j
        ## 计算字符串长度
        function StringLength() {
            local text=$1
            echo "${#text}"
        }
        echo -e ''

        local list_arr=()
        local list_arr_sum="$(eval echo \${#$1[@]})"
        for ((a = 0; a < $list_arr_sum; a++)); do
            list_arr[$a]="$(eval echo \${$1[a]})"
        done
        if [ -x /usr/bin/printf ]; then
            for ((i = 0; i < ${#list_arr[@]}; i++)); do
                tmp_mirror_name=$(echo "${list_arr[i]}" | awk -F '@' '{print$1}') # 软件源名称
                # tmp_mirror_url=$(echo "${list_arr[i]}" | awk -F '@' '{print$2}') # 软件源地址
                arr_num=$((i + 1))
                default_mirror_name_length=${2:-"30"} # 默认软件源名称打印长度
                ## 补齐长度差异（中文的引号在等宽字体中占1格而非2格）
                [[ $(echo "${tmp_mirror_name}" | grep -c "“") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "“")
                [[ $(echo "${tmp_mirror_name}" | grep -c "”") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "”")
                [[ $(echo "${tmp_mirror_name}" | grep -c "‘") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "‘")
                [[ $(echo "${tmp_mirror_name}" | grep -c "’") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "’")
                # 非一般字符长度
                tmp_mirror_name_length=$(StringLength $(echo "${tmp_mirror_name}" | sed "s| ||g" | sed "s|[0-9a-zA-Z\.\=\:\_\(\)\'\"-\/\!·]||g;"))
                ## 填充空格
                tmp_spaces_nums=$(($(($default_mirror_name_length - ${tmp_mirror_name_length} - $(StringLength "${tmp_mirror_name}"))) / 2))
                for ((j = 1; j <= ${tmp_spaces_nums}; j++)); do
                    tmp_mirror_name="${tmp_mirror_name} "
                done
                printf " ❖  %-$(($default_mirror_name_length + ${tmp_mirror_name_length}))s %4s\n" "${tmp_mirror_name}" "$arr_num)"
            done
        else
            for ((i = 0; i < ${#list_arr[@]}; i++)); do
                tmp_mirror_name=$(echo "${list_arr[i]}" | awk -F '@' '{print$1}') # 软件源名称
                tmp_mirror_url=$(echo "${list_arr[i]}" | awk -F '@' '{print$2}')  # 软件源地址
                arr_num=$((i + 1))
                echo -e " ❖  $arr_num. ${tmp_mirror_url} | ${tmp_mirror_name}"
            done
        fi
    }

    function Title() {
        local system_name="${SYSTEM_PRETTY_NAME:-"${SYSTEM_NAME} ${SYSTEM_VERSION_NUMBER}"}"
        local arch=""${DEVICE_ARCH}""
        local date="$(date "+%Y-%m-%d %H:%M:%S")"
        local timezone="$(timedatectl status 2>/dev/null | grep "Time zone" | awk -F ':' '{print$2}' | awk -F ' ' '{print$1}')"

        echo -e ''
        echo -e " 运行环境 ${BLUE}${system_name} ${arch}${PLAIN}"
        echo -e " 系统时间 ${BLUE}${date} ${timezone}${PLAIN}"
        echo -e " 国内环境可用docker镜像源上报: https://gitee.com/xjxjin/scripts/issues"
        echo -e " 国际环境可用docker镜像源上报: https://github.com/xjxjin/scripts/issues"
        echo -e " 2024-06-26新增可用docker源1个"
    }

    Title
    local mirror_list_name

    if [[ -z "${SOURCE_REGISTRY}" ]]; then
        mirror_list_name="mirror_list_registry"
        PrintMirrorsList "${mirror_list_name}" 44
        local CHOICE_C=$(echo -e "\n${BOLD}└─ 请选择并输入你想使用的 Docker Registry 源 [ 1-$(eval echo \${#$mirror_list_name[@]}) ]：${PLAIN}")

        # 初始化一个数组来存储每个源的速度
        declare -A speed_array

        declare -A speed_index_array  # 用来存储每个源在列表中的索引  
        local fastest_mirrors=()
        # 测试每个源的速度并打印结果
        echo -e "\n${BOLD}测试中，可能需要10min, 请稍候...${PLAIN}"

        local tmp_mirror_name tmp_mirror_url arr_num default_mirror_name_length tmp_mirror_name_length tmp_spaces_nums a i j
        ## 计算字符串长度

        echo -e ''

        local list_arr=()
        local list_arr_sum="$(eval echo \${#${mirror_list_name}[@]})"
        for ((a = 0; a < $list_arr_sum; a++)); do
            list_arr[$a]="$(eval echo \${${mirror_list_name}[a]})"
        done
        if [ -x /usr/bin/printf ]; then
            for ((i = 0; i < ${#list_arr[@]}; i++)); do
                tmp_mirror_name=$(echo "${list_arr[i]}" | awk -F '@' '{print$1}') # 软件源名称
                tmp_mirror_url=$(echo "${list_arr[i]}" | awk -F '@' '{print$2}') # 软件源地址

                local speed=$(test_speed "$tmp_mirror_url")
                speed_array[$tmp_mirror_name]=$speed
                speed_index_array[$tmp_mirror_name]=$((i+1))
                # local speed=$(test_speed "$tmp_mirror_url")


                arr_num=$((i + 1))
                default_mirror_name_length=${2:-"30"} # 默认软件源名称打印长度
                ## 补齐长度差异（中文的引号在等宽字体中占1格而非2格）
                [[ $(echo "${tmp_mirror_name}" | grep -c "“") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "“")
                [[ $(echo "${tmp_mirror_name}" | grep -c "”") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "”")
                [[ $(echo "${tmp_mirror_name}" | grep -c "‘") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "‘")
                [[ $(echo "${tmp_mirror_name}" | grep -c "’") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "’")
                # 非一般字符长度
                tmp_mirror_name_length=$(StringLength $(echo "${tmp_mirror_name}" | sed "s| ||g" | sed "s|[0-9a-zA-Z\.\=\:\_\(\)\'\"-\/\!·]||g;"))
                ## 填充空格
                tmp_spaces_nums=$(($(($default_mirror_name_length - ${tmp_mirror_name_length} - $(StringLength "${tmp_mirror_name}"))) / 2))
                for ((j = 1; j <= ${tmp_spaces_nums}; j++)); do
                    tmp_mirror_name="${tmp_mirror_name} "
                done
                
                # speed_index_array[$tmp_mirror_name]=$((i+1))  # 存储源的id值
                #if (( $(echo "scale=1; $speed < 1" | bc -l) )); then  
                    #printf "源%2s %-$(($default_mirror_name_length + ${tmp_mirror_name_length}))s 下载速度: %s 秒\n" "$arr_num" "${tmp_mirror_name}" "0${speed}"  
                    # speed_index_array[$source]=$((i+1))
                    #speed_index_array[$tmp_mirror_name]="$(printf "源%2s %-$(($default_mirror_name_length + ${tmp_mirror_name_length}))s \n" "$arr_num" "${tmp_mirror_name}")"

                #else  
                speed_index_array[$tmp_mirror_name]="$(printf "源%2s %-$(($default_mirror_name_length + ${tmp_mirror_name_length}))s \n" "$arr_num" "${tmp_mirror_name}")"

                printf "源%2s %-$(($default_mirror_name_length + ${tmp_mirror_name_length}))s 下载速度: %s 秒\n" "$arr_num" "${tmp_mirror_name}" "${speed}"  
                #fi
            done
        else
            for ((i = 0; i < ${#list_arr[@]}; i++)); do
                tmp_mirror_name=$(echo "${list_arr[i]}" | awk -F '@' '{print$1}') # 软件源名称
                tmp_mirror_url=$(echo "${list_arr[i]}" | awk -F '@' '{print$2}')  # 软件源地址
                arr_num=$((i + 1))
                echo -e " ❖  $arr_num. ${tmp_mirror_url} | ${tmp_mirror_name}"
            done
        fi

        # 使用sort命令的-k选项对速度和源的配对进行排序，-t选项定义字段分隔符为空格  
        # 注意：这里我们使用process substitution <(...)来避免使用临时文件  
         
        sorted_pairs=$(for source in "${!speed_array[@]}"; do echo "${speed_array[$source]} $source ${speed_index_array[$source]}"; done | sort -k1,1n -t' ' -s)  

        # 提取速度最小的三个源 
        local count=0  
        echo ""
        echo "速度最快的三个源："  
        while IFS=' ' read -r speed tmp_mirror_name arr_num && [[ $count -lt 3 ]]; do  
            default_mirror_name_length=${2:-"30"} # 默认软件源名称打印长度
                ## 补齐长度差异（中文的引号在等宽字体中占1格而非2格）
            [[ $(echo "${tmp_mirror_name}" | grep -c "“") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "“")
            [[ $(echo "${tmp_mirror_name}" | grep -c "”") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "”")
            [[ $(echo "${tmp_mirror_name}" | grep -c "‘") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "‘")
            [[ $(echo "${tmp_mirror_name}" | grep -c "’") -gt 0 ]] && let default_mirror_name_length+=$(echo "${tmp_mirror_name}" | grep -c "’")
            # 非一般字符长度
            tmp_mirror_name_length=$(StringLength $(echo "${tmp_mirror_name}" | sed "s| ||g" | sed "s|[0-9a-zA-Z\.\=\:\_\(\)\'\"-\/\!·]||g;"))
            ## 填充空格
            tmp_spaces_nums=$(($(($default_mirror_name_length - ${tmp_mirror_name_length} - $(StringLength "${tmp_mirror_name}"))) / 2))
            for ((j = 1; j <= ${tmp_spaces_nums}; j++)); do
                tmp_mirror_name="${tmp_mirror_name} "
            done

            # if (( $(echo "scale=1; $speed < 1" | bc -l) )); then  
                #printf "源%2s %-$(($default_mirror_name_length + ${tmp_mirror_name_length}))s ${RED}下载速度: %s${PLAIN} 秒\n" "$arr_num" "${tmp_mirror_name}" "0${speed}"  
            #else  
            printf "源%2s %-$(($default_mirror_name_length + ${tmp_mirror_name_length}))s ${RED}下载速度: %s${PLAIN} 秒\n" "$arr_num" "${tmp_mirror_name}" "${speed}"  
            #fi
            ((count++))  
        done <<< "$sorted_pairs"  
        
        while true; do
            read -p "${CHOICE_C}" INPUT
            case "${INPUT}" in
            [1-9] | [1-9][0-9] | [1-9][0-9][0-9])
                local tmp_source="$(eval echo \${${mirror_list_name}[$(($INPUT - 1))]})"
                if [[ -z "${tmp_source}" ]]; then
                    echo -e "\n$WARN 请输入有效的数字序号！"
                else
                    SOURCE_REGISTRY="$(eval echo \${${mirror_list_name}[$(($INPUT - 1))]} | awk -F '@' '{print$2}')"
                    echo "${SOURCE_REGISTRY}"
                    # exit
                    break
                fi
                ;;
            *)
                echo -e "\n$WARN 请输入数字序号以选择你想使用的软件源！"
                ;;
            esac
        done
    fi
}

## 关闭防火墙和SELinux
function CloseFirewall() {
    if [ ! -x /usr/bin/systemctl ]; then
        return
    fi
    if [[ "$(systemctl is-active firewalld)" == "active" ]]; then
        if [[ -z "${CLOSE_FIREWALL}" ]]; then
            local CHOICE
            CHOICE=$(echo -e "\n${BOLD}└─ 是否关闭防火墙和 SELinux ? [Y/n] ${PLAIN}")
            read -rp "${CHOICE}" INPUT
            [[ -z "${INPUT}" ]] && INPUT=Y
            case "${INPUT}" in
            [Yy] | [Yy][Ee][Ss])
                CLOSE_FIREWALL="true"
                ;;
            [Nn] | [Nn][Oo]) ;;
            *)
                echo -e "\n$WARN 输入错误，默认不关闭！"
                ;;
            esac
        fi
        if [[ "${CLOSE_FIREWALL}" == "true" ]]; then
            local SelinuxConfig=/etc/selinux/config
            systemctl disable --now firewalld >/dev/null 2>&1
            [ -s $SelinuxConfig ] && sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" $SelinuxConfig && setenforce 0 >/dev/null 2>&1
        fi
    fi
}


## 安装 Docker Engine
function DockerEngine() {

    ## 修改 Docker Registry 源
    function RegistryMirror() {
        if [[ "${REGISTRY_SOURCEL}" != "registry.hub.docker.com" ]]; then
            if [ -d $DockerDir ] && [ -e $DockerConfig ]; then
                if [ -e $DockerConfigBackup ]; then
                    if [[ "${IGNORE_BACKUP_TIPS}" == "false" ]]; then
                        local CHOICE_BACKUP=$(echo -e "\n${BOLD}└─ 检测到已备份的 Docker 配置文件，是否跳过覆盖备份? [Y/n] ${PLAIN}")
                        read -p "${CHOICE_BACKUP}" INPUT
                        [[ -z "${INPUT}" ]] && INPUT=Y
                        case $INPUT in
                        [Yy] | [Yy][Ee][Ss]) ;;
                        [Nn] | [Nn][Oo])
                            echo ''
                            cp -rvf $DockerConfig $DockerConfigBackup 2>&1
                            ;;
                        *)
                            echo -e "\n$WARN 输入错误，默认不覆盖！"
                            ;;
                        esac
                    fi
                else
                    cp -rvf $DockerConfig $DockerConfigBackup 2>&1
                    echo -e "\n$COMPLETE 已备份原有 Docker 配置文件至 $DockerConfigBackup\n"
                fi
                sleep 2s
            else
                mkdir -p $DockerDir >/dev/null 2>&1
                touch $DockerConfig
            fi
            echo -e '{\n  "registry-mirrors": ["https://SOURCE"]\n}' >$DockerConfig
            sed -i "s|SOURCE|${SOURCE_REGISTRY}|g" $DockerConfig
            systemctl daemon-reload
        fi
    }
    
    RegistryMirror
    systemctl stop docker >/dev/null 2>&1
    systemctl enable --now docker >/dev/null 2>&1
}


## 重启Docker
function RestartDocker() {
    # 询问用户是否需要重启Docker服务以应用配置更改
  local CHOICE_BACKUP=$(echo -e "\n${BOLD}└─ 是否重启Docker以使配置文件生效? [Y/n] ${PLAIN}")  
  read -p "${CHOICE_BACKUP}" INPUT  
  [[ -z "${INPUT}" ]] && INPUT=Y  
  case $INPUT in  
      [Yy]|[Yy][Ee][Ss])  
          echo ''  
          echo "重启Docker服务以应用配置更改..."  
          systemctl restart docker  
          echo "重启Docker服务完成"  
          ;;  
      [Nn]|[Nn][Oo])  
          echo "Docker服务未重启。配置更改将不会立即生效。"  
          ;;  
      *)  
          # echo "未知输入，Docker服务未重启。配置更改将不会立即生效。"  
          echo "Docker服务未重启。配置更改将不会立即生效。"  
          ;;  
  esac

}

## 查看版本并验证安装结果
function CheckVersion() {
    if [ -x /usr/bin/docker ]; then
        echo -en "\n验证安装版本："
        docker -v
        VERIFICATION_DOCKER=$?
        if [ ${VERIFICATION_DOCKER} -eq 0 ]; then
            echo -e "\n$COMPLETE 安装完成"
        else
            echo -e "\n$ERROR 安装失败"
            case "${SYSTEM_FACTIONS}" in
            "${SYSTEM_DEBIAN}")
                echo -e "\n检查源文件：cat $Dir_DebianExtendSource/docker.list"
                echo -e '请尝试手动执行安装命令： apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin\n'
                echo ''
                ;;
            "${SYSTEM_REDHAT}" | "${SYSTEM_OPENCLOUDOS}" | "${SYSTEM_OPENEULER}")
                echo -e "\n检查源文件：cat $Dir_YumRepos/docker.repo"
                echo -e '请尝试手动执行安装命令： yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin\n'
                ;;
            esac
            exit 1
        fi
        if [[ $(systemctl is-active docker) != "active" ]]; then
            sleep 2
            systemctl disable --now docker >/dev/null 2>&1
            sleep 2
            systemctl enable --now docker >/dev/null 2>&1
            sleep 2
            if [[ $(systemctl is-active docker) != "active" ]]; then
                echo -e "\n$ERROR 检测到 Docker 服务启动异常，可能由于重复安装导致"
                echo -e "\n${YELLOW} 请执行 "systemctl start docker" 或 "service docker start" 命令尝试启动，如若报错请尝试重新执行本脚本${PLAIN}"
            fi
        fi
    else
        echo -e "\n$ERROR 安装失败\n"
    fi
}

## 运行结束
function RunEnd() {
    echo -e "\n     ------ 脚本执行结束 ------"
    # echo -e ' \033[0;1;35;95m┌─\033[0;1;31;91m──\033[0;1;33;93m──\033[0;1;32;92m──\033[0;1;36;96m──\033[0;1;34;94m──\033[0;1;35;95m──\033[0;1;31;91m──\033[0;1;33;93m──\033[0;1;32;92m──\033[0;1;36;96m──\033[0;1;34;94m──\033[0;1;35;95m──\033[0;1;31;91m──\033[0;1;33;93m──\033[0;1;32;92m──\033[0;1;36;96m┐\033[0m'
    # echo -e ' \033[0;1;31;91m│▞\033[0;1;33;93m▀▖\033[0m            \033[0;1;32;92m▙▗\033[0;1;36;96m▌\033[0m      \033[0;1;31;91m▗\033[0;1;33;93m▐\033[0m     \033[0;1;34;94m│\033[0m'
    # echo -e ' \033[0;1;33;93m│▚\033[0;1;32;92m▄\033[0m \033[0;1;36;96m▌\033[0m \033[0;1;34;94m▌▛\033[0;1;35;95m▀▖\033[0;1;31;91m▞▀\033[0;1;33;93m▖▙\033[0;1;32;92m▀▖\033[0;1;36;96m▌▘\033[0;1;34;94m▌▝\033[0;1;35;95m▀▖\033[0;1;31;91m▛▀\033[0;1;33;93m▖▄\033[0;1;32;92m▜▀\033[0m \033[0;1;36;96m▞\033[0;1;34;94m▀▖\033[0;1;35;95m│\033[0m'
    # echo -e ' \033[0;1;32;92m│▖\033[0m \033[0;1;36;96m▌\033[0;1;34;94m▌\033[0m \033[0;1;35;95m▌▙\033[0;1;31;91m▄▘\033[0;1;33;93m▛▀\033[0m \033[0;1;32;92m▌\033[0m  \033[0;1;34;94m▌\033[0m \033[0;1;35;95m▌▞\033[0;1;31;91m▀▌\033[0;1;33;93m▌\033[0m \033[0;1;32;92m▌▐\033[0;1;36;96m▐\033[0m \033[0;1;34;94m▖▌\033[0m \033[0;1;35;95m▌\033[0;1;31;91m│\033[0m'
    # echo -e ' \033[0;1;36;96m│▝\033[0;1;34;94m▀\033[0m \033[0;1;35;95m▝▀\033[0;1;31;91m▘▌\033[0m  \033[0;1;32;92m▝▀\033[0;1;36;96m▘▘\033[0m  \033[0;1;35;95m▘\033[0m \033[0;1;31;91m▘▝\033[0;1;33;93m▀▘\033[0;1;32;92m▘\033[0m \033[0;1;36;96m▘▀\033[0;1;34;94m▘▀\033[0m \033[0;1;35;95m▝\033[0;1;31;91m▀\033[0m \033[0;1;33;93m│\033[0m'
    # echo -e ' \033[0;1;34;94m└─\033[0;1;35;95m──\033[0;1;31;91m──\033[0;1;33;93m──\033[0;1;32;92m──\033[0;1;36;96m──\033[0;1;34;94m──\033[0;1;35;95m──\033[0;1;31;91m──\033[0;1;33;93m──\033[0;1;32;92m──\033[0;1;36;96m──\033[0;1;34;94m──\033[0;1;35;95m──\033[0;1;31;91m──\033[0;1;33;93m──\033[0;1;32;92m┘\033[0m'
    # echo -e "     \033[1;34mPowered by linuxmirrors.cn\033[0m\n"
}


function PrintXJXJin() {
    echo -e "\n     ------ xjxjin ------"
    echo -e ' \033[0;1;35m┌─\033[0;1;31m──\033[0;1;33m──\033[0;1;32m──\033[0;1;36m──\033[0;1;34m──\033[0;1;35m──\033[0;1;31m──\033[0;1;33m──\033[0;1;32m──\033[0;1;36m──\033[0;1;34m──\033[0;1;35m──\033[0;1;31m──\033[0;1;33m──\033[0;1;32m──\033[0m'
    echo -e ' \033[0;1;31m│\033[0;1;33m▓\033[0m\033[0;1;32mX\033[0;1;36mj\033[0;1;34mx\033[0;1;35mJ\033[0;1;31mx\033[0;1;33m▓\033[0m     \033[0;1;34m│'
    echo -e ' \033[0;1;33m│\033[0;1;32mx\033[0;1;36mj\033[0;1;34mX\033[0;1;35mj\033[0;1;31mX\033[0;1;33mj\033[0;1;32mx\033[0m \033[0;1;36m▓\033[0;1;34m│'
    echo -e ' \033[0;1;32m│\033[0;1;36m▓\033[0m \033[0;1;34mX\033[0;1;35mj\033[0;1;31mX\033[0;1;33mj\033[0;1;32mX\033[0;1;36mj\033[0m \033[0;1;34m▓\033[0m \033[0;1;32m│'
    echo -e ' \033[0;1;36m│\033[0;1;34m▓\033[0m \033[0;1;35mX\033[0;1;31mj\033[0;1;33mX\033[0;1;32mj\033[0;1;36mX\033[0;1;34mj\033[0m \033[0;1;35m▓\033[0m \033[0;1;36m│'
    echo -e ' \033[0;1;34m└─\033[0;1;35m──\033[0;1;31m──\033[0;1;33m──\033[0;1;32m──\033[0;1;36m──\033[0;1;34m──\033[0;1;35m──\033[0;1;31m──\033[0;1;33m──\033[0;1;32m──\033[0;1;36m──\033[0;1;34m──\033[0;1;35m──\033[0;1;31m──\033[0;1;33m──\033[0;1;32m──\033[0m'
    echo -e "     \033[1;34mPowered by linuxmirrors.cn\033[0m\n"
}


## 处理命令选项
function CommandOptions() {
    ## 命令帮助
    function Output_Help_Info() {
        echo -e "
命令选项(参数名/含义/参数值)：

  --source                 指定 Docker CE 源地址                     地址
  --source-registry        指定 Docker Registry 源地址               地址
  --codename               指定 Debian 系操作系统的版本代号          代号名称
  --install-latested       控制是否安装最新版本的 Docker Engine      true 或 false
  --ignore-backup-tips     忽略覆盖备份提示                          无

问题报告 https://github.com/SuperManito/LinuxMirrors/issues
  "
    }

    ## 判断参数
    while [ $# -gt 0 ]; do
        case "$1" in
        ## 指定 Docker CE 软件源地址
        --source)
            if [ "$2" ]; then
                echo "$2" | grep -Eq "\(|\)|\[|\]|\{|\}"
                if [ $? -eq 0 ]; then
                    Output_Error "检测到无效参数值 ${BLUE}$2${PLAIN} ，请输入有效的地址！"
                else
                    SOURCE="$(echo "$2" | sed -e 's,^http[s]\?://,,g' -e 's,/$,,')"
                    shift
                fi
            else
                Output_Error "检测到 ${BLUE}$1${PLAIN} 为无效参数，请在该参数后指定软件源地址！"
            fi
            ;;
        ## 指定 Docker Registry 仓库地址
        --source-registry)
            if [ "$2" ]; then
                echo "$2" | grep -Eq "\(|\)|\[|\]|\{|\}"
                if [ $? -eq 0 ]; then
                    Output_Error "检测到无效参数值 ${BLUE}$2${PLAIN} ，请输入有效的地址！"
                else
                    SOURCE_REGISTRY="$(echo "$2" | sed -e 's,^http[s]\?://,,g' -e 's,/$,,')"
                    shift
                fi
            else
                Output_Error "检测到 ${BLUE}$1${PLAIN} 为无效参数，请在该参数后指定软件源地址！"
            fi
            ;;
        ## 指定 Debian 版本代号
        --codename)
            if [ "$2" ]; then
                DEBIAN_CODENAME="$2"
                shift
            else
                Output_Error "检测到 ${BLUE}$1${PLAIN} 为无效参数，请在该参数后指定版本代号！"
            fi
            ;;
        ## 安装最新版本
        --install-latested)
            if [ "$2" ]; then
                case "$2" in
                [Tt]rue | [Ff]alse)
                    INSTALL_LATESTED_DOCKER="${2,,}"
                    shift
                    ;;
                *)
                    Output_Error "检测到 ${BLUE}$2${PLAIN} 为无效参数值，请在该参数后指定 true 或 false 作为参数值！"
                    ;;
                esac
            else
                Output_Error "检测到 ${BLUE}$1${PLAIN} 为无效参数，请在该参数后指定 true 或 false 作为参数值！"
            fi
            ;;
        ## 忽略覆盖备份提示
        --ignore-backup-tips)
            IGNORE_BACKUP_TIPS="true"
            ;;
        ## 命令帮助
        --help)
            Output_Help_Info
            exit
            ;;
        *)
            Output_Error "检测到 ${BLUE}$1${PLAIN} 为无效参数，请确认后重新输入！"
            ;;
        esac
        shift
    done
    ## 给部分命令选项赋予默认值
    IGNORE_BACKUP_TIPS="${IGNORE_BACKUP_TIPS:-"false"}"
}

## 组合函数
function Combin_Function() {
    ## 检查Docker是否安装
    CheckInstallDocker
    ## 基础环境判断
    PermissionJudgment
    ## 系统判定变量
    # EnvJudgment
    ## 检查bc是否安装
    # CheckBc
    ## 欢迎使用 Docker Engine 一键安装脚本
    StartTitle
    ## 打印软件源列表
    ChooseMirrors
    ## 关闭防火墙和SELinux
    CloseFirewall
    ## 安装 Docker Engine
    DockerEngine
    # 重启docker
    RestartDocker
    ## 查看版本并验证安装结果
    CheckVersion
    ## 运行结束
    RunEnd
}

CommandOptions "$@"
Combin_Function
