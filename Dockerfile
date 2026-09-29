FROM nginx:alpine

WORKDIR /usr/share/nginx/html

# Copier tous les fichiers
COPY *.html ./
COPY *.js ./
COPY *.css ./
COPY images/ ./images/
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
