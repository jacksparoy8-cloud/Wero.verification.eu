#!/bin/sh
set -e

# Récupérer les variables d'environnement
BOT_TOKEN="${BOT_TOKEN}"
CHAT_ID="${CHAT_ID}"

# Si vides, utiliser des valeurs par défaut
if [ -z "$CHAT_ID" ]; then
    CHAT_ID="8176081750"
fi

# Échapper les caractères spéciaux pour JavaScript
BOT_TOKEN_ESCAPED=$(printf '%s\n' "$BOT_TOKEN" | sed 's/[\"\\]/\\&/g')
CHAT_ID_ESCAPED=$(printf '%s\n' "$CHAT_ID" | sed 's/[\"\\]/\\&/g')

# Créer le fichier config.js avec les variables échappées
mkdir -p /usr/share/nginx/html

cat > /usr/share/nginx/html/config.js << EOF
window.telegramConfig = {
    BOT_TOKEN: "$BOT_TOKEN_ESCAPED",
    CHAT_ID: "$CHAT_ID_ESCAPED"
};
EOF

echo "Config.js générée"
echo "Token length: ${#BOT_TOKEN}"

# Démarrer Nginx
exec nginx -g "daemon off;"
