FROM nginx:alpine

# Copier tous les fichiers HTML
COPY *.html /usr/share/nginx/html/

# Copier les fichiers JavaScript
COPY *.js /usr/share/nginx/html/

# Copier le dossier des images
COPY images/ /usr/share/nginx/html/images/

# Copier la configuration Nginx personnalisée
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copier le script d'entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exposer le port 80 (par défaut, Railway assignera son propre port)
EXPOSE 80

# Utiliser le script d'entrypoint
ENTRYPOINT ["/entrypoint.sh"]
