# Manual Técnico — Befine Store

**Versión:** 0.2 (09-oct-2026, Sprint 2) · **Audiencia:** desarrolladores y personal técnico que instale, despliegue o mantenga la plataforma · **Mantención post-entrega:** Plaxi Solutions

> Este manual crece en cada sprint. Las secciones marcadas *(S3)* o *(S4)* se completan cuando la funcionalidad exista.

---

## 1. Requisitos

| Componente | Versión / detalle | Uso |
|---|---|---|
| Git | 2.40+ | Control de versiones |
| Node.js | 20 o superior | Pruebas (`npm test`) y servidor local opcional |
| Docker + Docker Compose | Docker 24+ / Compose v2 | Ejecutar el sitio como contenedor (igual que en producción) |
| Supabase CLI *(opcional)* | 1.200+ | Migraciones y despliegue de Edge Functions desde la terminal |
| Cuenta Supabase | Plan gratuito (SC-04) | Base de datos, autenticación y Edge Functions |
| Navegador | Chrome, Firefox, Safari o Edge actualizados | Pruebas |

## 2. Estructura del repositorio

```
/
├── web/                     # Sitio público (lo que sirve nginx)
│   ├── index.html · catalogo.html · producto.html · checkout.html · cuenta.html
│   ├── css/                 # tokens → base → components → shell → página
│   ├── js/                  # data.js (único acceso a Supabase) + lógica por página
│   ├── assets/              # imágenes .webp optimizadas
│   └── supabase/functions/  # Edge Functions (Deno): resenas-google
├── tests/
│   ├── unit/                # 31 pruebas automatizadas (node:test)
│   └── helpers/cargar.js    # carga los mismos JS del sitio en Node
├── docker/nginx.conf        # configuración del servidor web
├── Dockerfile · docker-compose.yml · .dockerignore · .env.example
└── package.json             # scripts: npm test · npm start
```

Los scripts SQL de la base de datos se versionan en el repositorio de documentación (`05-Diseno/SQL/`); ver sección 4.

## 3. Instalación en un equipo nuevo

```bash
git clone https://github.com/IvnRP/befine-store.git
cd befine-store
cp .env.example .env        # completar solo si se van a desplegar Edge Functions
```

### 3.1 Opción A — Docker (recomendada, igual a producción)

```bash
docker compose up --build
# Abrir http://localhost:8080
```

Para detenerlo: `docker compose down`. Para usar otro puerto: `WEB_PORT=9090` en `.env`.

### 3.2 Opción B — Servidor estático simple

> No abrir los HTML con doble clic (`file://`): el inicio de sesión con Google y algunas rutas necesitan `http://`.

```bash
npm start                              # http-server en el puerto 8080
# o bien
cd web && python -m http.server 8080
# o bien: VS Code → extensión Live Server → "Open with Live Server" sobre web/index.html
```

### 3.3 Ejecutar las pruebas

```bash
npm test        # 31 pruebas unitarias; no requiere instalar dependencias
```

## 4. Base de datos (Supabase)

### 4.1 Crear la base desde cero

En **Supabase → SQL Editor**, ejecutar en este orden:

Los scripts están en el repositorio de documentación [Cmfg96/Documentos_Capstone_Grupo_N3](https://github.com/Cmfg96/Documentos_Capstone_Grupo_N3), carpeta `05-Diseno/SQL/`.

1. `05-Diseno/SQL/01_befine_store_schema.sql` — 21 tablas, tipos, funciones, triggers, índices y RLS.
2. `05-Diseno/SQL/02_befine_store_catalogo.sql` — catálogo real (productos, variantes, precios, zonas y cupón legacy).
3. `05-Diseno/SQL/03_migracion_20261009_01_seguridad_roles.sql` — roles y permisos, `crear_pedido()` y cupones.

### 4.2 Reglas para nuevas migraciones

- Nombre: `AAAAMMDD_NN_descripcion.sql` + `AAAAMMDD_NN_descripcion_reversa.sql`.
- Una migración **nunca borra datos** sin una reversa probada.
- Toda tabla nueva: `enable row level security` + políticas explícitas.

### 4.3 Crear el primer administrador

Tras registrar la cuenta del dueño desde `cuenta.html`, en el SQL Editor:

```sql
update public.perfiles set rol = 'admin'
where id = (select id from auth.users where email = '<correo-del-dueño>');
```

### 4.4 Configuración de Auth

| Opción (Supabase → Authentication) | Valor |
|---|---|
| Site URL / Redirect URLs | Dominio de producción y `http://localhost:8080` |
| Provider Google | Activado (client ID/secret de Google Cloud) |
| Leaked password protection | **Activada** |
| Anonymous sign-ins + Captcha | Activar juntos al aplicar la migración 03 *(S3)* |

## 5. Edge Functions y secretos

```bash
supabase login
supabase link --project-ref <ref-del-proyecto>
supabase secrets set --env-file .env          # GOOGLE_PLACES_KEY, MP_ACCESS_TOKEN, …
supabase functions deploy resenas-google
```

| Función | Propósito | Secretos | Estado |
|---|---|---|---|
| `resenas-google` | Reseñas reales de Google con caché de 1 h (≤ 1.000 consultas/mes, costo cero) | `GOOGLE_PLACES_KEY`, `GOOGLE_PLACE_ID` | ✅ |
| `mp-webhook` | Confirmar pagos de Mercado Pago (llama a `confirmar_pago`) | `MP_ACCESS_TOKEN`, `MP_WEBHOOK_SECRET`, `SUPABASE_SERVICE_ROLE_KEY` | *(S3)* |
| `emitir-dte` | Emitir boleta/factura en OpenFactura | `OPENFACTURA_API_KEY` | *(S3)* |

**Nunca** poner `service_role` ni tokens de pago en `web/`. La única clave en el frontend es la *anon/publishable* (pública por diseño, protegida por RLS).

## 6. Despliegue a producción

1. Fusionar a `main` mediante un pull request revisado.
2. Etiquetar la versión: `git tag v0.S.0 && git push --tags`.
3. Aplicar las migraciones nuevas en Supabase (SQL Editor o `supabase db push`).
4. Desplegar las Edge Functions modificadas.
5. Construir y publicar el frontend:
   ```bash
   docker build -t befine-store:v0.S.0 .
   docker run -d --name befine-store -p 80:80 --restart unless-stopped befine-store:v0.S.0
   ```
   (o subir la carpeta `web/` a un hosting estático con HTTPS).
6. Apuntar el DNS del dominio de Befine al servidor (el dominio actual de Shopify se reutiliza; SC-01).
7. Verificar: inicio, catálogo, ingreso y un pedido de prueba.

**Reversa:** volver a la imagen anterior (`docker run … befine-store:v0.(S-1).0`) y ejecutar el `*_reversa.sql` de la migración, si corresponde.

## 7. Respaldo y recuperación (RNF-10)

- El plan gratuito de Supabase (SC-04) no incluye respaldo diario automático. Se hace un **respaldo manual semanal** y **antes de cada migración**:
  ```bash
  supabase db dump -f respaldo_AAAAMMDD.sql            # estructura
  supabase db dump --data-only -f datos_AAAAMMDD.sql  # datos
  ```
  Los respaldos se guardan fuera de Supabase (nunca en el repositorio, porque contienen datos personales).
- Restauración: ejecutar los archivos en el SQL Editor de un proyecto limpio, en el mismo orden.

## 7.1 Evitar la pausa por inactividad (plan gratuito)

El plan gratuito pausa el proyecto tras 7 días sin actividad. Con pedidos diarios esto no ocurre; como respaldo, un ping diario programado (GitHub Actions con `schedule` o cualquier cron) consulta una tabla pública:

```bash
curl -s "$SUPABASE_URL/rest/v1/categorias?select=id&limit=1" -H "apikey: $SUPABASE_ANON_KEY"
```

Si el proyecto se pausa, se reactiva desde el panel (**Project → Restore**).

## 8. Solución de problemas

| Síntoma | Causa probable | Solución |
|---|---|---|
| El catálogo sale vacío | RLS bloquea la lectura o no hay productos activos | Revisar `productos.activo` y la política `productos_lectura` |
| "Google funciona al abrir el sitio desde un servidor" | Se abrió con `file://` | Usar Docker o un servidor local (sección 3) |
| El sitio no carga datos y el panel dice *Paused* | El proyecto se pausó por inactividad (plan gratuito) | Restaurarlo desde el panel y revisar el ping diario (sección 7.1) |
| No llegan los correos de confirmación | SMTP de Supabase con límite de envío | Configurar un SMTP propio en Authentication → SMTP |
| Las reseñas no aparecen | Falta el secreto `GOOGLE_PLACES_KEY` | `supabase secrets set` y volver a desplegar la función |
| Error `permission denied` al crear un pedido | Se intentó un `insert` directo | Usar `rpc("crear_pedido", …)` |
