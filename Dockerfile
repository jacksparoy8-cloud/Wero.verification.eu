FROM nginx:alpine

WORKDIR /usr/share/nginx/html

# Copier tous les fichiers
COPY *.html ./
COPY *.js ./
COPY *.css ./
COPY images/ ./images/
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    apk add --no-cache bash

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
