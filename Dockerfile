# Nginx Alpine
FROM nginx:alpine

# Info
LABEL maintainer="contato@rendev.com.br"
LABEL description="Rendev Website"

# Copiar arquivos do site para o diretório do Nginx
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/
COPY robots.txt /usr/share/nginx/html/
COPY sitemap.xml /usr/share/nginx/html/
COPY logo.png /usr/share/nginx/html/
COPY favicon.png /usr/share/nginx/html/

# Copiar configuração customizada do Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expor porta 80
EXPOSE 80

# Iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
