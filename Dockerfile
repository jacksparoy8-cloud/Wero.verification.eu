FROM node:20-alpine

# Installer Nginx
RUN apk add --no-cache nginx

WORKDIR /usr/share/nginx/html

# Copier tous les fichiers
COPY *.html ./
COPY *.js ./
COPY *.css ./
COPY images/ ./images/
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copier proxy
COPY proxy.js /app/proxy.js
COPY package.json /app/package.json

# Installer dépendances du proxy
WORKDIR /app
RUN npm install --production 2>/dev/null || true

# Copier start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80

ENTRYPOINT ["/start.sh"]
