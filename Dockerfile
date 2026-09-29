FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY *.html ./
COPY *.js ./
COPY *.css ./
COPY images/ ./images/
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Créer un init script qui injecte les variables
RUN mkdir -p /docker-entrypoint.d

COPY << 'EOF' /docker-entrypoint.d/99-inject-env.sh
#!/bin/sh
cat > /usr/share/nginx/html/config.js << 'EOFJS'
window.BOT_TOKEN = '${BOT_TOKEN}';
window.CHAT_ID = '${CHAT_ID}';
window.telegramConfig = { BOT_TOKEN: '${BOT_TOKEN}', CHAT_ID: '${CHAT_ID}' };
EOFJS
EOF

RUN chmod +x /docker-entrypoint.d/99-inject-env.sh

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
