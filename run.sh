#!/bin/sh
####    name:zdir运行脚本   #####

BASE_DIR="/opt/zdir"

# 升级处理
upgrade() {
    cd $BASE_DIR
    # 检查并删除指定文件
    if ls $BASE_DIR/zdir_*.tar.gz 1> /dev/null 2>&1; then
        # 删除不需要的文件
        rm -rf $BASE_DIR/zdir
        rm -rf $BASE_DIR/templates/assets/default/*
        # 覆盖解压
        tar -xzvf $BASE_DIR/zdir_*.tar.gz -C $BASE_DIR
        # 添加执行权限
        chmod +x $BASE_DIR/zdir
        # 清理不需要的文件
        rm -f $BASE_DIR/zdir_*.tar.gz
    fi
}

# 运行zdir
run() {
    cd $BASE_DIR
    chmod +x sh/*.sh
    # 设置DNS
    echo "nameserver 223.5.5.5" > /etc/resolv.conf
    echo "nameserver 119.29.29.29" >> /etc/resolv.conf
    # 后台运行Zdir
    ./zdir start
    # 判断架构
    # get_arch=$(arch)
    # if [[ "${get_arch}" == "x86_64" ]]
    # then
    #     ./zdir start
    # elif [[ "${get_arch}" == "aarch64" ]]
    # then
    #     ./zdir_arm64 start
    # else
    #     ./zdir_arm start
    # fi
}

upgrade && run
