FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY *.html ./
COPY *.js ./
COPY *.css ./
COPY images/ ./images/
COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN printf '#!/bin/sh\nprintf "window.BOT_TOKEN = \\"%s\\";\nwindow.CHAT_ID = \\"%s\\";\nwindow.telegramConfig = {\n    BOT_TOKEN: \\"%s\\",\n    CHAT_ID: \\"%s\\"\n};" "$BOT_TOKEN" "$CHAT_ID" "$BOT_TOKEN" "$CHAT_ID" > /usr/share/nginx/html/config.js\nexec nginx -g "daemon off;"\n' > /entrypoint.sh && chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
