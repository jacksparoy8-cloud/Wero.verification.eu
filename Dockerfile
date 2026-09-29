FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY *.html ./
COPY *.js ./
COPY *.css ./
COPY images/ ./images/
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Installer envsubst
RUN apk add --no-cache gettext

# Template pour config.js
COPY config.js.template /tmp/config.js.template

# Script d'entrée
RUN cat > /docker-entrypoint.sh << 'EOF'
#!/bin/sh
set -e
envsubst < /tmp/config.js.template > /usr/share/nginx/html/config.js
exec nginx -g "daemon off;"
EOF
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.sh"]
