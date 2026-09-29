#!/bin/sh
set -e

# Créer/mettre à jour config.js avec les variables d'environnement
cat > /usr/share/nginx/html/config.js << 'EOF'
window.telegramConfig = {
    BOT_TOKEN: window.BOT_TOKEN || '',
    CHAT_ID: window.CHAT_ID || '8176081750'
};
EOF

# Remplacer les tokens
sed -i "s|window.BOT_TOKEN || ''|'${BOT_TOKEN}'|g" /usr/share/nginx/html/config.js
sed -i "s|window.CHAT_ID || '8176081750'|'${CHAT_ID}'|g" /usr/share/nginx/html/config.js

echo "✓ Config Telegram injectée"

# Démarrer Nginx
exec nginx -g "daemon off;"
