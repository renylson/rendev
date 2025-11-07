# 🐳 Guia Docker - Site Rendev

## 🚀 Início Rápido

### Pré-requisitos
- Docker instalado ([Instalar Docker](https://docs.docker.com/get-docker/))
- Docker Compose instalado (já vem com Docker Desktop)

---

## 📦 Opção 1: Docker Compose (Recomendado)

### Iniciar o site:
```bash
docker-compose up -d
```

### Ver logs:
```bash
docker-compose logs -f
```

### Parar o site:
```bash
docker-compose down
```

### Reiniciar:
```bash
docker-compose restart
```

### Acessar:
Abra o navegador em: **http://localhost**

---

## 🔧 Opção 2: Docker Manual

### 1. Construir a imagem:
```bash
docker build -t rendev-site .
```

### 2. Executar o container:
```bash
docker run -d -p 80:80 --name rendev-website rendev-site
```

### 3. Ver logs:
```bash
docker logs -f rendev-website
```

### 4. Parar:
```bash
docker stop rendev-website
```

### 5. Remover:
```bash
docker rm rendev-website
```

---

## 🌐 Mudar Porta

Se a porta 80 estiver em uso, altere no `docker-compose.yml`:

```yaml
ports:
  - "8080:80"  # Agora acesse em http://localhost:8080
```

Ou no comando manual:
```bash
docker run -d -p 8080:80 --name rendev-website rendev-site
```

---

## 🔍 Comandos Úteis

### Ver containers rodando:
```bash
docker ps
```

### Ver todos os containers:
```bash
docker ps -a
```

### Entrar no container:
```bash
docker exec -it rendev-website sh
```

### Ver uso de recursos:
```bash
docker stats rendev-website
```

### Health check:
```bash
docker inspect --format='{{json .State.Health}}' rendev-website
```

---

## 🔄 Atualizar o Site

### 1. Modificar os arquivos (HTML, CSS, JS)

### 2. Reconstruir:
```bash
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

Ou manual:
```bash
docker stop rendev-website
docker rm rendev-website
docker build -t rendev-site .
docker run -d -p 80:80 --name rendev-website rendev-site
```

---

## 🌍 Deploy em Servidor (Produção)

### VPS/Cloud (DigitalOcean, AWS, etc):

1. **Instalar Docker no servidor:**
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

2. **Enviar arquivos via Git ou SCP:**
```bash
# Git
git clone https://github.com/seu-usuario/rendev-site.git
cd rendev-site

# Ou SCP
scp -r * usuario@servidor:/home/usuario/rendev-site/
```

3. **Iniciar no servidor:**
```bash
cd /home/usuario/rendev-site
docker-compose up -d
```

4. **Configurar domínio:**
- Aponte o DNS do domínio para o IP do servidor
- Configure um reverse proxy (Nginx/Traefik) para SSL

---

## 🔒 HTTPS com Let's Encrypt

### Usando Nginx Proxy Manager (Recomendado):

1. **Adicionar ao docker-compose.yml:**
```yaml
version: '3.8'

services:
  nginx-proxy:
    image: jc21/nginx-proxy-manager:latest
    container_name: nginx-proxy-manager
    ports:
      - "80:80"
      - "443:443"
      - "81:81"
    volumes:
      - ./proxy-data:/data
      - ./proxy-letsencrypt:/etc/letsencrypt
    restart: unless-stopped
    networks:
      - rendev-network

  rendev-site:
    build: .
    container_name: rendev-website
    expose:
      - "80"
    restart: unless-stopped
    networks:
      - rendev-network

networks:
  rendev-network:
    driver: bridge
```

2. **Acessar painel:**
- URL: `http://seu-servidor:81`
- Email: `admin@example.com`
- Senha: `changeme`

3. **Configurar SSL:**
- Adicionar Proxy Host
- Domain: `rendev.com.br`
- Forward to: `rendev-website:80`
- SSL: Request SSL Certificate (Let's Encrypt)

---

## 📊 Monitoramento

### Ver logs em tempo real:
```bash
docker-compose logs -f rendev-site
```

### Verificar saúde:
```bash
docker inspect rendev-website | grep -A 10 Health
```

### Estatísticas de uso:
```bash
docker stats
```

---

## 🐛 Troubleshooting

### Porta 80 já em uso:
```bash
# Windows
netstat -ano | findstr :80

# Linux/Mac
lsof -i :80

# Matar processo (Windows)
taskkill /PID [número] /F
```

### Container não inicia:
```bash
docker logs rendev-website
```

### Rebuild completo:
```bash
docker-compose down
docker system prune -a
docker-compose up -d --build
```

### Limpar tudo:
```bash
docker system prune -a --volumes
```

---

## 📦 Publicar no Docker Hub (Opcional)

### 1. Login:
```bash
docker login
```

### 2. Tag:
```bash
docker tag rendev-site seu-usuario/rendev-site:latest
```

### 3. Push:
```bash
docker push seu-usuario/rendev-site:latest
```

### 4. Usar em outro lugar:
```bash
docker pull seu-usuario/rendev-site:latest
docker run -d -p 80:80 seu-usuario/rendev-site:latest
```

---

## 💡 Dicas

✅ Use `docker-compose` - é mais fácil!
✅ Sempre use `-d` para rodar em background
✅ Configure volumes se precisar persistir dados
✅ Use `.dockerignore` para arquivos desnecessários
✅ Monitore logs regularmente
✅ Faça backup das imagens importantes

---

## 🎯 Resumo de Comandos

```bash
# Iniciar
docker-compose up -d

# Parar
docker-compose down

# Logs
docker-compose logs -f

# Rebuild
docker-compose up -d --build

# Status
docker ps

# Entrar no container
docker exec -it rendev-website sh
```

---

## ✅ Pronto!

Seu site Rendev está rodando em Docker! 🐳

**Acesse:** http://localhost

Para produção, configure SSL e aponte seu domínio para o servidor.

---

💙 **Bom desenvolvimento!**
