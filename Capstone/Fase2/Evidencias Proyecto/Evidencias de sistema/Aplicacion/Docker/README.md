# Docker — Befine Store

Copia de los archivos de Docker del repositorio de código **[IvnRP/befine-store](https://github.com/IvnRP/befine-store)**, donde se ejecutan (van en la raíz, junto a la carpeta `web/`). Actualizada el 20-nov-2026, igual a `main` (commit 01c138a).

Docker es el despliegue reproducible del proyecto. La tienda en producción (aguabefine.cl) se publica en Cloudflare Pages (CM-04); ambos sirven el mismo sitio con las mismas cabeceras de seguridad.

| Archivo | Para qué sirve |
|---|---|
| `Dockerfile` | Construye la imagen: nginx 1.27 (alpine) + la carpeta `web/` (sin `web/supabase`) |
| `docker-compose.yml` | Levanta el contenedor en `http://localhost:8080` |
| `docker/nginx.conf` | Compresión, caché, cabeceras de seguridad y direcciones amigables `/productos/<nombre>` |
| `.dockerignore` | Excluye `.git`, `.env` y el código de las Edge Functions |
| `.env.example` | `WEB_PORT` y los **nombres** de los secretos de las Edge Functions, sin valores |

Uso (desde el repositorio de código):

```bash
docker compose up -d --build
```

Instrucciones completas: Manual Técnico v1.0 (`Evidencias de documentacion/07-Operacion/Manual_Tecnico.docx`), sección 3.
