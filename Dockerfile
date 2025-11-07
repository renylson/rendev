# Use Nginx Alpine (leve e seguro)
FROM nginx:alpine

# Metadados
LABEL maintainer="contato@rendev.com.br"
LABEL description="Rendev - Desenvolvimento de Soluções Digitais"

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

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:8045 || exit 1

# Comando para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]
