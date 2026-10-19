# Arquitectura de la solución — Befine Store

**Versión:** 2.0 (09-oct-2026, posterior a la SC-02) · **Responsables:** Carlos Fuentes (datos/backend) · Felipe Moraga (frontend)

## 1. Estilo arquitectónico

**Cliente web estático + Backend as a Service (BaaS).**

- **Frontend:** sitio **multipágina** en HTML5, CSS3 y JavaScript *vanilla* (una página por pantalla), **sin herramienta de build**. Se sirve como archivos estáticos (nginx en Docker o hosting estático con HTTPS).
- **Backend:** **Supabase** = PostgreSQL 15 + Auth + Row Level Security (RLS) + Edge Functions (Deno) + Storage.
- **Integraciones:** Mercado Pago (cobro), OpenFactura/Haulmer (DTE ante el SII), Google Places (reseñas) y WhatsApp (enlace `wa.me`).

El navegador consulta Supabase directamente con la **clave pública *anon***. La seguridad **no** depende del frontend: la aplica la base de datos con **RLS** y **funciones `SECURITY DEFINER`** que validan permisos. Las operaciones con secretos (pagos, DTE, reseñas) viven en **Edge Functions**, donde las claves se guardan como *secrets*.

## 2. Diagrama de componentes

```mermaid
flowchart TB
  subgraph Cliente["Navegador (móvil / escritorio)"]
    direction TB
    UI["Páginas HTML<br/>index · catalogo · producto · checkout · cuenta · admin*"]
    JS["Capa JS<br/>shell.js · ui.js · fx.js · forms.js · store.js"]
    API["Puente de datos<br/>data.js → window.Befine"]
    LS[("localStorage<br/>carrito · datos recordados")]
    UI --> JS --> API
    JS --> LS
  end

  subgraph Supabase["Supabase (BaaS)"]
    AUTH["Auth<br/>correo/contraseña · Google OAuth"]
    REST["PostgREST<br/>API REST automática"]
    DB[("PostgreSQL<br/>21 tablas + roles/permisos<br/>RLS en todas las tablas")]
    RPC["Funciones SQL<br/>crear_pedido() · tiene_permiso()<br/>marcar_reparto()* · confirmar_pago()*"]
    EF["Edge Functions (Deno)<br/>resenas-google · mp-webhook* · emitir-dte*"]
    REST --> DB
    RPC --> DB
    EF --> RPC
  end

  subgraph Externos["Servicios externos"]
    MP["Mercado Pago"]
    OF["OpenFactura / SII"]
    GP["Google Places API"]
    WA["WhatsApp (wa.me)"]
  end

  API -- "supabase-js (HTTPS + anon key)" --> AUTH
  API --> REST
  API --> RPC
  API -- "functions.invoke" --> EF
  EF --> GP
  EF -- "preferencia de pago" --> MP
  MP -- "webhook" --> EF
  EF --> OF
  JS -. "abre enlace con mensaje" .-> WA

  classDef pend stroke-dasharray: 5 5
  class EF,RPC pend
```
<sub>\* Componentes en construcción (Sprint 3–4) o escritos y pendientes de aplicar.</sub>

## 3. Capas del frontend

| Capa | Archivos | Responsabilidad |
|---|---|---|
| Presentación | `*.html`, `css/tokens.css → base.css → components.css → shell.css → <página>.css` | Estructura semántica y estilos por capas; la marca se cambia solo en `tokens.css` |
| Interacción | `shell.js`, `ui.js`, `fx.js`, `water.js`, `bands.js`, `scenes.js`, `transitions.js` | Navbar/footer compartidos, carrito *drawer*, efectos (agua reactiva, escenas por horario) |
| Lógica de página | `home.js`, `catalogo.js`, `producto.js`, `checkout.js`, `cuenta.js` | Orquesta cada pantalla |
| Utilidades | `forms.js`, `store.js`, `perf.js` | Validación chilena (RUT, celular), estado del carrito, ajuste de rendimiento según el dispositivo |
| Acceso a datos | `data.js` (`window.Befine`) | **Único** punto que habla con Supabase; la UI nunca consulta tablas directamente |

**Regla de diseño:** toda la interfaz depende de `window.Befine`. Cambiar el origen de un dato (de un arreglo local a Supabase, o de una tabla a una función) no obliga a tocar las pantallas.

## 4. Seguridad por diseño

| Amenaza | Control |
|---|---|
| Un cliente manipula el precio o el total desde el navegador | Inserción directa en `pedidos`/`detalle_pedido` **cerrada**; solo `crear_pedido()` crea pedidos y recalcula precios, despacho y cupones desde la BD |
| Un cliente se marca un pago como aprobado o se regala puntos | `pagos`, `documentos_tributarios` y `movimientos_puntos` solo se escriben con `service_role` (webhook) |
| Un usuario se asigna el rol admin | El rol no lo elige el usuario; un trigger bloquea el auto-escalamiento de rol, nivel o puntos |
| Un chofer ve más de lo necesario | Permiso `pedidos.ver` / `pedidos.repartir`; política `direcciones_reparto` limitada a los pedidos |
| Exposición de secretos | Solo la clave *anon* (pública por diseño) en el código; `service_role`, Mercado Pago, OpenFactura y Google como *secrets* de Edge Functions; `.env` en `.gitignore` |
| XSS | Toda salida dinámica pasa por `esc()`; `textContent` en lugar de `innerHTML` para datos del usuario |
| Redirección abierta | `cuenta.html?volver=` solo acepta páginas propias (`^[\w-]+\.html$`) |

## 5. Despliegue

```mermaid
flowchart LR
  Dev["Desarrollador<br/>(rama feature)"] -- "pull request + revisión" --> GH["GitHub<br/>rama main"]
  GH -- "docker build" --> IMG["Imagen nginx:alpine<br/>con /web"]
  IMG --> HOST["Servidor / hosting con HTTPS<br/>dominio de Befine (DNS)"]
  GH -- "supabase db push / SQL Editor" --> SB["Supabase (plan gratuito)<br/>migraciones versionadas"]
  GH -- "supabase functions deploy" --> EFN["Edge Functions"]
```

- **Ambientes:** local (Docker o Live Server) → producción (Supabase, plan gratuito por decisión del cliente — SC-04 — + hosting). Las migraciones se aplican en orden y cada una tiene su script de reversa.
- **Configuración:** las variables de cada ambiente se describen en `.env.example` (nunca se sube `.env`).

## 6. Decisiones de arquitectura (ADR resumidos)

| # | Decisión | Alternativas | Motivo |
|---|---|---|---|
| ADR-01 | Supabase como backend | Backend propio (Node/Express) | Auth, RLS y API listos; el equipo concentra las 18 semanas en el producto |
| ADR-02 | HTML/CSS/JS en lugar de Flutter Web (SC-02) | Flutter Web, React | Carga liviana, SEO y control total de la experiencia; sin curva de Dart |
| ADR-03 | Sin bundler (sin Vite) | Vite / Webpack | Simplicidad para un equipo de 3; se puede incorporar después sin rehacer el código |
| ADR-04 | Lógica de dinero en el servidor (`crear_pedido`, `confirmar_pago`) | Calcular en el navegador | El navegador no es confiable para precios, pagos ni puntos |
| ADR-05 | Roles y permisos en tablas (RBAC configurable) | `enum` fijo de roles | El dueño puede crear roles nuevos sin cambiar el código |
| ADR-06 | Avisos por enlace `wa.me` en el MVP | API WhatsApp Business | La API exige verificación de Meta y plantillas aprobadas; queda como trabajo futuro |
