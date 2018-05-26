FROM nginx:1.13.12-alpine

RUN rm -f /etc/nginx/conf.d/*
COPY ./docker/nginx/nginx.conf /etc/nginx/conf.d/web.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf