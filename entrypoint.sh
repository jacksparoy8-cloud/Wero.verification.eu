#!/bin/sh

# Créer/mettre à jour config.js avec les variables d'environnement
cat > /usr/share/nginx/html/config.js << EOF
window.telegramConfig = {
    BOT_TOKEN: '${BOT_TOKEN:-}',
    CHAT_ID: '${CHAT_ID:-8176081750}'
};
window.BOT_TOKEN = '${BOT_TOKEN:-}';
window.CHAT_ID = '${CHAT_ID:-8176081750}';
EOF

echo "Config Telegram injectée ✓"
echo "BOT_TOKEN: ${BOT_TOKEN:0:10}***"
echo "CHAT_ID: $CHAT_ID"

# Démarrer Nginx
exec nginx -g "daemon off;"
