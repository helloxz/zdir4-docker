FROM alpine:3.16
RUN mkdir -p /opt/zdir
WORKDIR /opt/zdir
#复制启动文件
COPY *.sh /root/
# 定义架构参数
ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH}

# 打印架构信息以供调试
RUN echo "Building for architecture: ${TARGETARCH}"
# 安装
RUN sh /root/install.sh
# 暴露文件夹和端口
VOLUME /opt/zdir/data
EXPOSE 6080
CMD ["/usr/sbin/run.sh"]
