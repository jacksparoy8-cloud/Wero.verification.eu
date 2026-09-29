FROM nginx:alpine

# Copier tous les fichiers HTML
COPY *.html /usr/share/nginx/html/

# Copier les fichiers JavaScript et CSS
COPY *.js /usr/share/nginx/html/
COPY *.css /usr/share/nginx/html/

# Copier le dossier des images
COPY images/ /usr/share/nginx/html/images/

# Copier la configuration Nginx personnalisée
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposer le port 80
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
