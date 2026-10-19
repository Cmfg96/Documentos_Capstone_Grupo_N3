# Docker — Befine Store

Copia de los archivos de Docker del repositorio de código **[IvnRP/befine-store](https://github.com/IvnRP/befine-store)**, donde se ejecutan (van en la raíz, junto a la carpeta `web/`).

| Archivo | Para qué sirve |
|---|---|
| `Dockerfile` | Construye la imagen: nginx 1.27 (alpine) + la carpeta `web/` |
| `docker-compose.yml` | Levanta el contenedor en `http://localhost:8080` |
| `docker/nginx.conf` | Compresión gzip, caché de imágenes y cabeceras de seguridad |
| `.dockerignore` | Excluye `.git`, `.env` y el código de las Edge Functions |
| `.env.example` | Variables de entorno de ejemplo (`WEB_PORT`) |

Uso (desde el repositorio de código):

```bash
docker compose up --build
```

Instrucciones completas: [Manual Técnico](../Manual_Tecnico.md), sección 3.1.
