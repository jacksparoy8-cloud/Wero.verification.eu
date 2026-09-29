FROM node:20-alpine AS base

# Stage 1: Préparer les fichiers
FROM base AS builder
WORKDIR /app
COPY proxy.js .
COPY package.json .
RUN npm install --production 2>/dev/null || true

# Stage 2: Image finale
FROM nginx:alpine

# Copier Node depuis le builder
COPY --from=base /usr/local/bin/node /usr/local/bin/
COPY --from=base /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

WORKDIR /usr/share/nginx/html

# Copier tous les fichiers
COPY *.html ./
COPY *.js ./
COPY *.css ./
COPY images/ ./images/
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copier proxy et start script
COPY proxy.js /app/proxy.js
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80

ENTRYPOINT ["/start.sh"]
