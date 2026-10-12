# Befine Store — Documentación del Proyecto

**Grupo N3 · Plaxi Solutions · Capstone PTY4614 · Duoc UC Plaza Norte · 2026-2**

---

## ¿Qué es Befine Store?

Befine Store es una plataforma de comercio electrónico web propia (mobile-first) desarrollada como proyecto de título para reemplazar la tienda Shopify de **Agua Purificada Befine**, una microempresa de distribución de agua purificada a domicilio en Quilicura, Santiago, con ~450 clientes activos y ~1.000 entregas mensuales.

**Problema que resuelve:** Shopify genera costos recurrentes, personalización limitada e información dispersa entre WhatsApp y la tienda. Befine Store centraliza pedidos, clientes y reparto en un sistema propio, con pago en línea, emisión automática de boletas/facturas y un panel de administración con roles delegables.

**Repositorio del código fuente:** [IvnRP/befine-store](https://github.com/IvnRP/befine-store)

---

## Tecnologías

| Capa | Tecnología |
|---|---|
| Frontend | HTML5 / CSS3 / JavaScript vanilla (mobile-first, sin framework) |
| Backend / BaaS | Supabase (PostgreSQL + RLS, Auth, Edge Functions en Deno) |
| Pagos | Mercado Pago (API de preferencias + webhook) |
| Facturación electrónica | OpenFactura (Haulmer) — boletas y facturas para el SII |
| Contenedor | Docker + nginx |
| Reseñas | Google Places API New (Edge Function con caché de 1 h) |
| Control de versiones | Git / GitHub |
| Pruebas | node:test (Node ≥ 20, sin dependencias externas) |
| Gestión del proyecto | GitHub Projects (Kanban), GitHub Issues (historias de usuario) |

---

## Cómo ejecutar en local

### Requisitos

- Git 2.40+
- Docker 24+ con Docker Compose v2 (recomendado)
- Node.js 20+ (solo para las pruebas)

### Opción A — Docker (igual a producción)

```bash
git clone https://github.com/IvnRP/befine-store.git
cd befine-store
cp .env.example .env   # completar las claves si se van a probar pagos o funciones
docker compose up --build
# Abrir http://localhost:8080
```

### Opción B — Servidor estático

```bash
cd web
npx http-server -p 8080
# o: python -m http.server 8080
# No abrir con doble clic (file://): el login con Google requiere http://
```

### Ejecutar las pruebas

```bash
npm test   # 31 pruebas unitarias — no requiere instalar dependencias
```

Salida esperada: `# tests 31 | # pass 31 | # fail 0`

---

## Integrantes y roles

| Nombre | Rol en el equipo | Rol Scrum (rotativo) |
|---|---|---|
| **Iván Rodríguez Pinares** | Desarrollo backend, base de datos, integración, patrocinador (dueño de Befine) | Product Owner · Scrum Master Sprint 2 |
| **Carlos Fuentes González** | Datos, reportes, gestión documental, programación | Scrum Master Sprint 3 |
| **Felipe Moraga López** | Interfaz de usuario, diseño visual frontend | Scrum Master Sprint 1 |

---

## Metodología

El proyecto usa una **metodología híbrida PMBOK + Scrum**:

- **PMBOK (predictivo)** para la dirección del proyecto: inicio, planificación, monitoreo y control, y cierre — con 12 planes de gestión, líneas base y control de cambios formal (SC-01 a SC-04).
- **Scrum (adaptativo)** para la construcción del producto: sprints de 2 semanas, Product Backlog priorizado con 30 historias de usuario (issues en GitHub), Sprint Review con el patrocinador y retrospectivas.

**¿Por qué híbrida?** El plazo académico fijo de 18 semanas exige hitos comprometidos (PMBOK), mientras que las reglas del negocio (cupones, puntos, reparto) se descubren al construir (Scrum). Cascada pura fue descartada porque los requisitos cambiaron en la semana 7 (SC-02); Scrum puro fue descartado porque la asignatura exige planes formales de costo, riesgos y adquisiciones.

Detalle completo: [`02-Metodologia/Metodologia_Hibrida_PMBOK_Scrum.md`](Fase2/Evidencias%20Grupales/02-Metodologia/Metodologia_Hibrida_PMBOK_Scrum.md)

---

## Arquitectura

```
Navegador (móvil / escritorio)
  └── HTML + CSS + JS vanilla
        └── data.js → window.Befine (único punto de acceso a Supabase)

Supabase (BaaS)
  ├── Auth (correo/contraseña + Google OAuth)
  ├── PostgreSQL — 21 tablas + RLS en todas las tablas
  ├── Funciones SQL — crear_pedido(), tiene_permiso(), marcar_reparto()
  └── Edge Functions (Deno) — resenas-google, mp-webhook*, emitir-dte*

Servicios externos
  ├── Mercado Pago — pagos en línea (preferencias + webhook)
  ├── OpenFactura / SII — boletas y facturas electrónicas
  ├── Google Places API — reseñas reales en la tienda
  └── WhatsApp (wa.me) — avisos de reparto al cliente
```

La clave frontend (`anon`) es pública por diseño y está protegida por RLS. Las claves secretas (`service_role`, `MP_ACCESS_TOKEN`, `OPENFACTURA_API_KEY`) viven solo en las Edge Functions y nunca en el código del cliente.

Detalle completo: [`05-Diseno/Arquitectura.md`](Fase2/Evidencias%20Grupales/05-Diseno/Arquitectura.md) · Diagramas UML: [`05-Diseno/Diagramas_UML.md`](Fase2/Evidencias%20Grupales/05-Diseno/Diagramas_UML.md)

---

## Innovación

Befine Store incorpora tres elementos diferenciadores respecto a una tienda genérica:

1. **Experiencia adaptativa por hora del día** — la página de inicio cambia su hero, paleta de color y saludo según si es madrugada, mañana, tarde o noche, y muestra los productos "más pedidos" según la franja horaria real del negocio.
2. **Seguridad por diseño** — RLS habilitado en las 21 tablas, `crear_pedido()` recalcula precios desde la BD (ignora los enviados por el cliente), sistema de roles y permisos configurable por el dueño.
3. **Costo cero de plataforma** — elimina la suscripción mensual a Shopify; el costo anual total conocido es $508.795 CLP (servicios de facturación y certificado digital), financiado por el cliente.

Detalle completo: [`07-Operacion/Innovacion_y_Valor.md`](Fase2/Evidencias%20Grupales/07-Operacion/Innovacion_y_Valor.md)

---

## Estructura del repositorio de documentación

La documentación de la Fase 2 está en `Fase2/Evidencias Grupales/` (la de la Fase 1, en `Capstone/Fase1/`).

```
📄 2.4_GuiaEstudiante…, Informe_Evidencias…   Informe de Avance (Guía 2.4) e Informe de Evidencias con capturas
📁 01-Inicio/          Acta de constitución y documento de inicio del proyecto
📁 02-Metodologia/     Metodología híbrida PMBOK + Scrum (declaración y justificación)
📁 03-Scrum/           Product Vision, Product Backlog, Sprint Backlogs, DoD, Retrospectivas
📁 04-Requisitos/      Especificación de requerimientos (SRS), requisitos no funcionales
📁 05-Diseno/          Arquitectura, diagramas UML, modelo de datos, scripts SQL
📁 06-Calidad/         Plan de pruebas con casos y resultados
📁 07-Operacion/       Manual técnico, archivos Docker e innovación
📁 08-Gestion-PMBOK/   12 planes de gestión, anexos, solicitudes de cambio (SC-01 a SC-04)
📁 09-Evidencias-Sistema/  Capturas de la aplicación, Docker, base de datos, pruebas y gestión (con README)
```

Cada documento está en dos formatos: **`.md`** (se lee directo en GitHub, con diagramas Mermaid) y **`.docx`** (Word, con los diagramas como imágenes).

---

*Proyecto de Título — Ingeniería en Informática · Duoc UC Plaza Norte · Semestre 2026-2*
