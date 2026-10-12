# Sprint Backlog — Sprint 2 (en curso)

| Campo | Valor |
|---|---|
| **Sprint** | 2 de 4 (Fase de Ejecución) |
| **Fechas** | 05-oct-2026 → 18-oct-2026 (semanas 9–10) |
| **Scrum Master / líder de sprint** | Iván Rodríguez |
| **Product Owner** | Iván Rodríguez |
| **Equipo** | Carlos Fuentes · Iván Rodríguez · Felipe Moraga |
| **Objetivo del sprint** | *Que un cliente pueda completar un pedido real y seguro (creado en el servidor, sin pago aún), con roles admin y chofer protegidos en la base de datos y el código integrado en `main`.* |
| **Estado al 09-oct** | Día 5 de 10 |

## Historias y tareas

| ID | Tarea | Responsable | Estado |
|---|---|---|---|
| **SC-03 / HU-31** | Migración `20261009_01_seguridad_roles` + reversa: roles y permisos configurables, `tiene_permiso()`, RLS por permiso; prueba en seco con 37 casos | Carlos Fuentes | ✅ |
| **SC-03 / HU-06** | Función `crear_pedido()` en el servidor: precios, despacho, cupón y puntos desde la base | Carlos Fuentes | ✅ |
| **SC-03 / HU-20** | Cupones generales y personales validados en el servidor | Carlos Fuentes | ✅ |
| HU-16 / HU-19 | Redactar las migraciones 02 (reparto y WhatsApp) y 03 (invitados y confirmación de pago) con sus reversas | Carlos Fuentes | ✅ (por aplicar en S3) |
| **HU-06** | Conectar `checkout.js` a `crear_pedido()` (reemplaza el modo demostración) | Iván Rodríguez | 🟨 |
| **HU-05** | Guardar la dirección de despacho del cliente en `direcciones` para la próxima compra | Carlos Fuentes / Felipe Moraga | ⬜ |
| **HU-07** | Panel de pedidos con estados (admin): permisos y RLS listos con la SC-03; la pantalla se replanifica al S3 junto a la vista del chofer | Carlos Fuentes | 🟨 |
| **HU-04** | Guardar el carrito del cliente con sesión en `carritos` / `items_carrito` | Iván Rodríguez / Carlos Fuentes | ⬜ |
| **HU-18** | Historial real de pedidos en "Mi cuenta" | Iván Rodríguez | ⬜ |
| **HU-01** | Configurar el ingreso con Google (cliente OAuth) en Supabase | Iván Rodríguez | ⬜ |
| **HU-31** | Asignar el rol admin a la cuenta del dueño | Iván Rodríguez (PO) | ⬜ |
| **CFG-06** | Revisar y aprobar el PR #19 y la rama CFG-04; integrar a `main` y actualizar `web/README.md` | Felipe Moraga (revisión) / Iván Rodríguez | 🟨 |
| **SC-04** | Plan gratuito de Supabase: ping programado diario y respaldo manual semanal | Carlos Fuentes | 🟨 |
| **HU-14** *(adelantada del S4)* | Dockerfile + docker-compose, manual técnico de despliegue y pruebas unitarias automatizadas (31 pruebas) | Felipe Moraga / Iván Rodríguez | ✅ |
| — | Pruebas de aceptación de cuenta y checkout en celular y computador, tema claro y oscuro | Felipe Moraga | 🟨 |
| — | Refinamiento del backlog: crear las issues HU-16 a HU-31 en GitHub y artefactos Scrum en el repositorio (Product Vision, Product Backlog, Sprint Backlogs, DoD, retrospectivas) | Felipe Moraga | 🟨 |
| — | Informe de Avance Fase 2 (entrega 12-oct) | Todo el equipo | 🟨 |

## Riesgos activos

- **R5 — Credenciales de Mercado Pago y OpenFactura:** solicitarlas en este sprint para no bloquear el Sprint 3.
- **R7 — Plan gratuito de Supabase (SC-04):** ping y respaldo manual en curso.
- **R3 — Disponibilidad vespertina:** la entrega del Informe de Avance coincide con este sprint.

## Avance al día 5

| Indicador | Valor |
|---|---|
| Tareas terminadas | 5 de 17 |
| Tareas en curso | 7 |
| Tareas pendientes | 5 |
| Lectura | La seguridad del pedido (lo más crítico) ya está terminada; el cierre del sprint depende de conectar el checkout a `crear_pedido()` e integrar el código a `main`. |

---

# Planificación de los sprints siguientes (tentativa)

| Sprint | Fechas | Líder | Objetivo | Historias |
|---|---|---|---|---|
| **3** | 19-oct → 01-nov | Carlos Fuentes | Cobrar y facturar de verdad; operar el reparto | HU-08, HU-09 (pago y confirmación), HU-10 (DTE en certificación), HU-07 (panel de pedidos), HU-16 y HU-17 (chofer y WhatsApp), HU-19 (invitados) |
| **4** | 02-nov → 14-nov | Felipe Moraga | Panel de administración completo y preparación del Go-Live | HU-03, HU-11, HU-12, HU-13, HU-20 a HU-31 (incluye la pantalla de roles, HU-31); pruebas de integración, seguridad y rendimiento; despliegue |

> El Sprint 4 concentra muchas historias: si la capacidad no alcanza, se postergan primero las P3 (HU-26 a HU-30 y el canje de puntos HU-12), según el Plan de Cronograma ("se reprioriza alcance antes que pedir extensión").
