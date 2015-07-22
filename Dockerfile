FROM ubuntu:14.04
MAINTAINER Daisuke Fujita <dtanshi45@gmail.com> (@dtan4)

ENV NGINX_VERSION 1.8.0
ENV NGX_MRUBY_VERSION 1.11.12

RUN apt-get update && \
    apt-get install -y bison curl gcc git make libpcre3 libpcre3-dev libssl-dev rake && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --recursive --branch v${NGX_MRUBY_VERSION} --depth 1 https://github.com/matsumoto-r/ngx_mruby.git /tmp/ngx_mruby-${NGX_MRUBY_VERSION} && \
    cd /tmp/ngx_mruby-${NGX_MRUBY_VERSION} && \
    ./configure --with-ngx-src-root=/tmp/nginx-${NGINX_VERSION} && \
    make build_mruby && \
    make generate_gems_config

RUN curl -L http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz > /tmp/nginx-${NGINX_VERSION}.tar.gz && \
    cd /tmp && \
    tar zxf nginx-${NGINX_VERSION}.tar.gz && \
    cd /tmp/nginx-${NGINX_VERSION} && \
    ./configure \
      --prefix=/opt/nginx \
      --conf-path=/etc/nginx/nginx.conf \
      --sbin-path=/opt/nginx/sbin/nginx \
      --with-http_stub_status_module \
      --add-module=/tmp/ngx_mruby-${NGX_MRUBY_VERSION} && \
    make && \
    make install && \
    rm -rf /tmp/*

COPY files/nginx.conf /etc/nginx/nginx.conf
COPY files/hello.rb /opt/nginx/html/hello.rb

EXPOSE 80

CMD ["/opt/nginx/sbin/nginx"]
