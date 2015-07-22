FROM ubuntu:14.04
MAINTAINER Daisuke Fujita <dtanshi45@gmail.com> (@dtan4)

ENV NGINX_VERSION 1.8.0

RUN apt-get update && \
    apt-get install -y curl gcc make libpcre3 libpcre3-dev libssl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz > /tmp/nginx-${NGINX_VERSION}.tar.gz && \
    cd /tmp && \
    tar zxf nginx-${NGINX_VERSION}.tar.gz

RUN cd /tmp/nginx-${NGINX_VERSION} && \
    ./configure \
      --prefix=/opt/nginx \
      --conf-path=/etc/nginx/nginx.conf \
      --sbin-path=/opt/nginx/sbin/nginx \
      --with-http_stub_status_module && \
    make && \
    make install && \
    rm -rf /tmp/*

COPY files/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["/opt/nginx/sbin/nginx"]
