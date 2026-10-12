# Plan de Pruebas — Befine Store

**Versión:** 1.1 (10-oct-2026) · **Base:** Plan de Gestión de la Calidad v1.1 (§6 KPI, §8 control de calidad) · **Responsable:** líder de sprint vigente

## 1. Objetivo

Verificar que Befine Store cumple sus requerimientos funcionales (RF-01 a RF-25) y no funcionales (RNF-01 a RNF-14) antes del Go-Live (21-nov-2026). Las pruebas se ejecutan **dentro de cada sprint** (no en una fase separada): una historia no está terminada si sus pruebas no pasan ([Definition of Done](../03-Scrum/Definition_of_Done.md), punto 8).

## 2. Alcance y niveles de prueba

| Nivel | Qué se prueba | Herramienta | Cuándo | Estado |
|---|---|---|---|---|
| **Unitarias** | Reglas de negocio en JS: validaciones (RUT, celular, correo), carrito, despacho por comuna y envío gratis, días hábiles de entrega, formato CLP, franjas horarias | `node:test` (incluido en Node ≥ 20, sin dependencias) — carpeta `tests/unit/` | En cada sprint | ✅ **31 pruebas, 31 aprobadas** |
| **Base de datos / seguridad (RLS)** | Que cada rol solo vea y modifique lo permitido; que `crear_pedido()` ignore precios enviados por el cliente | Scripts SQL con `set role` + claims JWT en una rama de Supabase; consultas como visitante anónimo desde el navegador | S2–S3 | 🟨 CP-S09 y CP-S11 aprobadas; el resto en S3 |
| **Integración** | Carrito → `crear_pedido()` → Mercado Pago (*sandbox*) → webhook → OpenFactura (certificación) | Tarjetas de prueba de MP + ambiente de certificación SII | S3–S4 | ⬜ |
| **Sistema / E2E** | Flujo completo en el navegador: comprar, crear cuenta, ver pedido; flujo del chofer | Pruebas manuales con casos documentados (Playwright opcional) | S3–S4 | 🟨 Manuales en S1–S2 |
| **Rendimiento** | LCP, Performance, ≥ 100 pedidos/hora, ≤ 5 s por pedido, 500 usuarios simultáneos | Lighthouse (móvil) + k6 | S2 (línea base) y S4 | 🟨 Línea base Lighthouse medida el 10-oct (ver 4.5); k6 en S4 |
| **Aceptación (UAT)** | Operación real del negocio validada por el dueño | Guion UAT firmado por Iván Rodríguez | Semana previa al Go-Live | ⬜ |

## 3. Cómo ejecutar las pruebas automatizadas

```bash
# Requisito: Node.js 20 o superior
npm test
```

Salida esperada (resumen):

```
# tests 31
# pass 31
# fail 0
```

Las pruebas cargan **los mismos archivos** que usa el sitio (`web/js/forms.js`, `store.js`, `data.js`, `bands.js`) en un contexto aislado de Node (`tests/helpers/cargar.js`), así que no se duplica código y una regresión en el sitio rompe la prueba.

## 4. Casos de prueba

### 4.1 Unitarias (automatizadas) — ✅ ejecutadas el 09-oct-2026

| ID | Archivo | Caso | Requisito | Resultado |
|---|---|---|---|---|
| CP-U01 | `forms.test.js` | RUT válido con y sin formato, con DV numérico y K | RF-01, RF-08 | ✅ |
| CP-U02 | `forms.test.js` | RUT con DV incorrecto, corto o vacío se rechaza | RF-08 | ✅ |
| CP-U03 | `forms.test.js` | Celular chileno con +56, espacios o guiones; rechaza fijos | RF-06 | ✅ |
| CP-U04 | `forms.test.js` | Formato de correo y fuerza de contraseña 0–4 | RF-01, RNF-04 | ✅ |
| CP-U05 | `carrito.test.js` | Misma variante suma cantidades; total y conteo | RF-05 | ✅ |
| CP-U06 | `carrito.test.js` | Cantidad 0 o negativa elimina el ítem | RF-05 | ✅ |
| CP-U07 | `carrito.test.js` | Persistencia en localStorage y notificación a suscriptores | RF-05 | ✅ |
| CP-U08 | `despacho.test.js` | Quilicura gratis; tarifa bajo el mínimo; gratis desde $7.000 (límite incluido) | RF-06, RF-21 | ✅ |
| CP-U09 | `despacho.test.js` | Comuna sin cobertura → no permite continuar | RF-06 | ✅ |
| CP-U10 | `despacho.test.js` | Entrega estándar al siguiente día hábil; 20 fechas agendables sin fines de semana | RF-06 | ✅ |
| CP-U11 | `despacho.test.js` | Formato CLP `$1.234.567` | RNF-14 | ✅ |
| CP-U12 | `horario.test.js` | Franja y saludo correctos en los 8 bordes horarios; mensaje de "vuelta" para clientes registrados | Innovación UX | ✅ |

### 4.2 Funcionales manuales (sistema) — Sprints 1 y 2

| ID | Caso | Pasos | Resultado esperado | Resultado |
|---|---|---|---|---|
| CP-F01 | Catálogo desde la BD | Abrir `catalogo.html` | Se listan los productos activos de Supabase con su precio | ✅ |
| CP-F02 | Búsqueda sin tildes | Buscar "bidon" | Aparece "Bidón" | ✅ |
| CP-F03 | Variante y precio | En la ficha, cambiar de variante | Cambian el precio y el stock mostrados | ✅ |
| CP-F04 | Registro | Crear cuenta con un correo nuevo | Llega el correo de confirmación; el perfil queda con rol `cliente` | ✅ |
| CP-F05 | Correo duplicado | Registrar el mismo correo | Mensaje de error claro, sin crear una segunda cuenta | ✅ |
| CP-F06 | Recuperar contraseña | "Olvidé mi contraseña" | Llega el enlace y permite definir una nueva | ✅ |
| CP-F07 | Despacho en el checkout | Elegir Huechuraba con subtotal $5.000 y luego $7.000 | $2.500 y luego "gratis" | ✅ |
| CP-F08 | Validación en línea | Ingresar un RUT inválido | Error bajo el campo, anunciado al lector de pantalla | ✅ |
| CP-F09 | Compra como invitado en menos de 1 minuto | Agregar un producto y completar el checkout sin cuenta | Pedido creado en menos de 1 minuto | ⬜ (S3, requiere `crear_pedido()` conectado) |
| CP-F10 | Reseñas reales de Google | Abrir el inicio | Se muestran la nota y reseñas reales desde la Edge Function | ✅ |
| CP-F11 | Responsivo y modo día/noche | Abrir cada página en celular y computador, en modo día y noche | Contenido legible y sin desbordes | ✅ |


### 4.3 Seguridad (S2–S3)

| ID | Caso | Resultado esperado |
|---|---|---|
| CP-S01 | Un cliente intenta `insert` directo en `pedidos` | Rechazado por RLS |
| CP-S02 | Un cliente envía un precio alterado a `crear_pedido()` | El pedido usa el precio de la BD |
| CP-S03 | Un cliente intenta cambiar su `rol` a `admin` | Bloqueado por trigger |
| CP-S04 | Un chofer intenta editar un producto | Rechazado (sin permiso `catalogo.gestionar`) |
| CP-S05 | Un cliente consulta pedidos de otro cliente | 0 filas |
| CP-S06 | Un cupón personal usado por otro cliente | Rechazado por `crear_pedido()` |
| CP-S07 | Webhook con monto distinto al total | El pedido no pasa a `pagado` |
| CP-S08 | Webhook repetido | No duplica stock ni puntos (idempotencia) |
| CP-S09 | Un visitante anónimo consulta `pedidos` y `perfiles` | 0 filas en ambas; `productos` sí devuelve el catálogo — ✅ ejecutada el 10-oct-2026 |
| CP-S10 | Un visitante anónimo intenta modificar un parámetro de negocio | Rechazado por RLS |
| CP-S11 | Revisión del código del frontend | Solo contiene la clave pública (*anon*); ninguna `service_role` ni token de pago — ✅ revisada el 07-oct-2026 |

### 4.4 Integración (planificadas, S3–S4)

| ID | Caso | Resultado esperado |
|---|---|---|
| CP-I01 | Pago aprobado con tarjeta de prueba de MP | Pedido `pagado` → `en_preparacion`; stock descontado; puntos sumados |
| CP-I02 | Pago rechazado | Pedido sigue en `pendiente_pago` |
| CP-I03 | Emisión de boleta en certificación | Folio y PDF guardados en `documentos_tributarios` |
| CP-I04 | Emisión de factura con RUT de empresa | Factura emitida con razón social y giro |
| CP-I05 | Chofer marca "En camino" y "Entregado" | Historial registrado y enlace de WhatsApp con el mensaje correcto |

### 4.5 Rendimiento — línea base (Lighthouse móvil, 10-oct-2026)

| Página | Rendimiento | Accesibilidad | Buenas prácticas | SEO | LCP | CLS |
|---|---|---|---|---|---|---|
| Inicio | 73 | 84 | 100 | 100 | 3,0 s | 0,501 |
| Catálogo | 70 | 96 | 100 | 100 | 3,2 s | 0,507 |

La meta (rendimiento ≥ 90 y LCP ≤ 2,5 s) aún no se cumple. La causa principal es el desplazamiento del contenido durante la carga (CLS ≈ 0,50 en ambas páginas), lo que apunta a un elemento compartido (barra superior, fuentes o fondo). Se registra como mejora para el Sprint 4.

## 5. Criterios de entrada y salida

- **Entrada:** historia con criterios de aceptación definidos y desplegada en el ambiente de prueba.
- **Salida (Go-Live):** 100 % de los casos críticos (pago, facturación y pedidos) aprobados; 0 defectos críticos abiertos; Lighthouse Performance ≥ 90; UAT firmada.

## 6. Gestión de defectos

Cada defecto se registra como *issue* en GitHub con la etiqueta `bug`, su severidad (crítico/alto/medio/bajo), los pasos para reproducirlo y el caso de prueba asociado. Un defecto crítico bloquea el cierre del sprint.
