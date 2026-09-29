#!/bin/sh
set -e

# Récupérer les variables d'environnement
BOT_TOKEN="${BOT_TOKEN}"
CHAT_ID="${CHAT_ID:-8176081750}"

echo "Injectant BOT_TOKEN et CHAT_ID dans les fichiers HTML..."

# Remplacer {{BOT_TOKEN}} et {{CHAT_ID}} dans tous les HTML
find /usr/share/nginx/html -name "*.html" -type f -exec sed -i "s|{{BOT_TOKEN}}|$BOT_TOKEN|g" {} \;
find /usr/share/nginx/html -name "*.html" -type f -exec sed -i "s|{{CHAT_ID}}|$CHAT_ID|g" {} \;

echo "Injection complétée"

# Démarrer Nginx
exec nginx -g "daemon off;"
