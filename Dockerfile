FROM ubuntu:18.04 as build

LABEL org.opencontainers.image.authors="76527413@qq.com"

RUN sed -i s/archive.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list && \
    sed -i s/security.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list && \
    apt update && \
    apt install -y git g++ make libssl-dev libgflags-dev libprotobuf-dev libprotoc-dev protobuf-compiler libleveldb-dev && \
    apt install -y libsnappy-dev libgoogle-perftools-dev libgoogle-glog-dev && \
    apt install -y cmake && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://hub.fastgit.org/apache/incubator-brpc.git && \
    git clone https://hub.fastgit.org/brpc/media-server.git && \
    # build brpc
    cd /incubator-brpc && \
    sh config_brpc.sh --headers=/usr/include --libs=/usr/lib && \
    make && \
    # build media server
    cd /media-server && \
    mkdir build && cd build && cmake  -D BRPC_INCLUDE_PATH=/incubator-brpc/output/include -D BRPC_LIB=/incubator-brpc/output/lib/libbrpc.a .. && make -sj4 && \
    # mv and clear
    mkdir /brpc-media-server && \
    mv /media-server/build/output/bin/media_server /brpc-media-server/ && \
    rm -rf /incubator-brpc && \
    rm -rf /media-server && \
    apt purge -y git g++ cmake && apt autoremove -y

WORKDIR /brpc-media-server
EXPOSE 8079

CMD /brpc-media-server/media_server