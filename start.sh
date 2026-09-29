#!/bin/sh
set -e

# Générer config.js
cat > /usr/share/nginx/html/config.js << EOF
window.BOT_TOKEN = "${BOT_TOKEN}";
window.CHAT_ID = "${CHAT_ID}";
window.telegramConfig = {
    BOT_TOKEN: "${BOT_TOKEN}",
    CHAT_ID: "${CHAT_ID}"
};
EOF

# Démarrer proxy Node en arrière-plan
node /app/proxy.js &

# Démarrer Nginx au premier plan
exec nginx -g "daemon off;"
