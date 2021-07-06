FROM primetoninc/jdk:1.8

LABEL org.opencontainers.image.authors="76527413@qq.com"

ENV VERSION=0.14.12.4
ENV NAME=PALO-${VERSION}-release-binary
ENV FILE=${NAME}.tar.gz

RUN wget https://palo-cloud-repo-bd.bd.bcebos.com/baidu-doris-release/${FILE} &&\
    tar -zxvf ${FILE} &&\
    mv $NAME /doris &&\
    rm -rf ${FILE}

CMD /doris/be/bin/start_be.sh & /doris/fe/bin/start_fe.sh