# http://doris.incubator.apache.org/downloads/downloads.html#apache-doris
FROM apache/incubator-doris:build-env-for-1.0.0 AS build

ENV NAME=apache-doris-1.0.0-incubating-src
ENV FILE=${NAME}.tar.gz
RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/doris/1.0/1.0.0-incubating/${FILE} --no-check-certificate
RUN tar -zxvf ${FILE} && mv ${NAME} /source
WORKDIR /source 
RUN USE_AVX2=0  sh build.sh

FROM adoptopenjdk/openjdk11

LABEL org.opencontainers.image.authors="76527413@qq.com"
WORKDIR /doris
COPY --from=build output .

CMD /doris/be/bin/start_be.sh & /doris/fe/bin/start_fe.sh
# CMD bash