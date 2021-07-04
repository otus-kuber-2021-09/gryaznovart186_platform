FROM nginx:1.21.0
WORKDIR /app

RUN groupadd -g 1001 www \
&& useradd -u 1001 -ms /bin/bash -g www www \
&& sed -i "s|user  nginx;|user  1001;|g" /etc/nginx/nginx.conf \
&& touch /var/run/nginx.pid \
&& chown -R 1001:1001 /var/cache/nginx /run /var/log/nginx

COPY kubernetes-intro/web/web.conf /etc/nginx/conf.d/

EXPOSE 8000
USER 1001
