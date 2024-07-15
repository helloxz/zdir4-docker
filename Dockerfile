FROM alpine:3.16
RUN mkdir -p /opt/zdir
WORKDIR /opt/zdir
#复制启动文件
COPY *.sh /root/
# 安装
RUN sh /root/install.sh ${TARGETARCH}
# 暴露文件夹和端口
VOLUME /opt/zdir/data
EXPOSE 6080
CMD ["/usr/sbin/run.sh"]
