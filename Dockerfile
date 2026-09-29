FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY *.html ./
COPY *.js ./
COPY *.css ./
COPY images/ ./images/
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
