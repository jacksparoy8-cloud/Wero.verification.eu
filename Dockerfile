FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY *.html ./
COPY *.js ./
COPY *.css ./
COPY images/ ./images/
COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN apk add --no-cache gettext

RUN cat > /entrypoint.sh << 'SCRIPT'
#!/bin/sh
cat > /usr/share/nginx/html/config.js << 'CONFIG'
window.BOT_TOKEN = "$BOT_TOKEN";
window.CHAT_ID = "$CHAT_ID";
window.telegramConfig = {
    BOT_TOKEN: "$BOT_TOKEN",
    CHAT_ID: "$CHAT_ID"
};
CONFIG
exec nginx -g "daemon off;"
SCRIPT

RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
