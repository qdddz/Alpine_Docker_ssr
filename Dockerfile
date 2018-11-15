FROM alpine:3.8

ARG TZ="Asia/Shanghai"
RUN apk upgrade --update 
RUN apk add py3-lxml python3 curl --no-cache --virtual .build-deps tar \
      --no-cache --virtual .build-deps wget \
      --no-cache --virtual .build-deps openssl \
      --no-cache --virtual .build-depslibsodium-dev \
&& pip3 install pip==10.0.0 \
&& pip3 freeze \
&& wget -O /tmp/shadowsocksr.tar.gz https://github.com/shadowsocksrr/shadowsocksr/archive/manyuser.zip \
&& wget -O /root/ss.json https://github.com/qdddz/Alpine_Docker_ssr/raw/master/ss.json \
&& tar zxf /tmp/shadowsocksr.tar.gz -C /tmp \
&& mv /tmp/shadowsocksr/shadowsocks /usr/local/ \
&& rm -fr /tmp/shadowsocksr \
&& rm -f /tmp/shadowsocksr.tar.gz 

RUN echo "nohup python3 /usr/local/shadowsocks/server.py -c /root/ss.json &" >/root/start.sh
RUN chmod 755 /root/start.sh
CMD ["/bin/sh", "/root/start.sh"]
