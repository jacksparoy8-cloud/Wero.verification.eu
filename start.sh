#!/bin/sh

# Générer config.js
cat > /usr/share/nginx/html/config.js << EOF
window.BOT_TOKEN = "${BOT_TOKEN}";
window.CHAT_ID = "${CHAT_ID}";
window.telegramConfig = {
    BOT_TOKEN: "${BOT_TOKEN}",
    CHAT_ID: "${CHAT_ID}"
};
EOF

echo "Config générée avec BOT_TOKEN: ${BOT_TOKEN:0:10}..."

# Démarrer proxy Node en arrière-plan
echo "Démarrage du proxy Node..."
node /app/proxy.js > /tmp/proxy.log 2>&1 &
NODE_PID=$!
echo "Node PID: $NODE_PID"

sleep 2

# Vérifier que Node a démarré
if ! kill -0 $NODE_PID 2>/dev/null; then
    echo "ERREUR: Node n'a pas démarré"
    cat /tmp/proxy.log
    exit 1
fi

echo "Proxy Node démarré avec succès"

# Démarrer Nginx au premier plan
echo "Démarrage de Nginx..."
exec nginx -g "daemon off;"
