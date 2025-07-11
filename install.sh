#!/bin/sh

VERSION=4.6.0
BASE_DIR="/opt/zdir"
# 获取架构
ARCH=${TARGETARCH}

# 初始化环境
init() {
    #更新软件
    apk update
    #安装timezone
    apk add -U tzdata
    #安装必要软件
    apk add curl wget fuse3
    #查看时区列表
    ls /usr/share/zoneinfo
    #拷贝需要的时区文件到localtime
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    #查看当前时间
    date
    #为了精简镜像，可以将tzdata删除了
    apk del tzdata
    #拷贝运行文件
    chmod +x /root/run.sh
    cp /root/run.sh /usr/sbin/
}

#下载Zdir
download(){
    cd /root && mkdir zdir && cd zdir
    if [ "$ARCH" = "amd64" ]; then
        name=zdir_${VERSION}_linux_amd64.tar.gz
    elif [ "$ARCH" = "arm64" ]; then
        name=zdir_${VERSION}_linux_arm64.tar.gz
    elif [ "$ARCH" = "arm" ]; then
        name=zdir_${VERSION}_linux_arm.tar.gz
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi
    
    wget http://soft.xiaoz.org/zdir/${VERSION}/${name}

    #解压
    tar -xvf ${name}
    #拷贝文件
    cp -ar /root/zdir/* ${BASE_DIR}
    #添加执行权限
    chmod +x ${BASE_DIR}/zdir
    #删除压缩文件
    rm -rf /root/${name}
    rm -rf ${BASE_DIR}/*.tar.gz

    #删除临时目录
    rm -rf /tmp/*

    
    #删除临时目录
    rm -rf /root/zdir
}


init && download
