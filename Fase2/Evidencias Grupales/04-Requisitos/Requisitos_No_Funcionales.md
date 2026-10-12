# Requisitos No Funcionales (RNF) — Befine Store

**Fuente:** Planilla y Especificación de Requerimientos (Grupo N3), actualizadas por la SC-02 y la SC-04 · **Versión:** 1.2 (09-oct-2026)

Los RNF son **transversales**: se verifican en todos los sprints mediante la [Definition of Done](../03-Scrum/Definition_of_Done.md) y el [Plan de Pruebas](../06-Calidad/Plan_de_Pruebas.md). Cada uno tiene una **métrica verificable** y una **forma de prueba**.

| ID | Categoría | Requisito | Métrica / criterio de aceptación | Cómo se verifica | Estado |
|---|---|---|---|---|---|
| RNF-01 | Usabilidad (diseño) | Mobile-first y responsive en la tienda y en el panel | Sin scroll horizontal a 360 px; layout correcto a 360 / 768 / 1280 px | Revisión en DevTools (DoD #4) | 🟨 Aplicado en las pantallas construidas |
| RNF-02 | Usabilidad | Flujo de compra simple y rápido | Compra completa en ≤ 1 minuto y ≤ 3 secciones en el checkout | Prueba de usuario cronometrada (UAT) | 🟨 Checkout en una sola página |
| RNF-03 | Rendimiento | Procesar pedidos sin degradar la experiencia | ≥ 100 pedidos/hora; crear un pedido en ≤ 5 s; Lighthouse Performance ≥ 90; LCP ≤ 2,5 s en móvil | Lighthouse + prueba de carga con k6 sobre `crear_pedido()` | ⬜ Se mide en el S4 |
| RNF-04 | Seguridad | Contraseñas cifradas, RLS, protección contra inyección SQL/XSS, HTTPS, sin datos de tarjeta | 0 accesos indebidos en las pruebas de RLS; contraseñas gestionadas por Supabase Auth (bcrypt); escape de HTML en toda salida dinámica | Pruebas de seguridad por rol (Plan de Pruebas §4.3) | 🟨 RLS + roles aplicados (mig. 01); salida escapada con `esc()` |
| RNF-05 | Privacidad | Cumplimiento de la Ley 21.719 | Política de privacidad publicada; datos mínimos; acceso solo del titular y del admin | Revisión legal + pruebas RLS | 🟨 RLS listo; falta publicar la política |
| RNF-06 | Disponibilidad | Disponible en el horario de operación de Befine según el nivel de servicio del plan gratuito del proveedor (SC-04) | Sin pausas del proyecto por inactividad; ping programado diario; aviso de caídas | Monitoreo de actividad y estado del proyecto en Supabase | ⬜ Al Go-Live |
| RNF-07 | Escalabilidad | Hasta 500 usuarios simultáneos | Sin errores 5xx con 500 usuarios virtuales | k6 (prueba de carga) | ⬜ S4 |
| RNF-08 | Compatibilidad | Chrome, Firefox, Safari y Edge; PWA en Android/iOS | Flujo de compra completo en los 4 navegadores | Matriz de navegadores en el S4 | 🟨 Probado en Chrome/Edge |
| RNF-09 | Trazabilidad | Registro auditable de cada cambio de un pedido | 100 % de los cambios de estado en `historial_pedido` con usuario y hora | Prueba de integración del flujo de reparto | 🟨 Diseñado (mig. 02) |
| RNF-10 | Respaldo | Copias periódicas y recuperación sencilla | Respaldo manual semanal y antes de cada migración (`supabase db dump`), guardado fuera de Supabase; procedimiento de restauración documentado | Simulacro de restauración en un entorno de prueba | ⬜ S4 |
| RNF-11 | Mantenibilidad | Actualizar sin afectar a los usuarios; agregar productos sin tocar código | Catálogo, precios, zonas y parámetros editables desde la BD; migraciones con reversa; código por capas | Revisión de arquitectura | ✅ Arquitectura aplicada |
| RNF-12 | Accesibilidad | WCAG 2.1 AA | Lighthouse Accessibility ≥ 90; `alt`, foco visible, `aria-*` en errores; respeta `prefers-reduced-motion` | Lighthouse + revisión manual | 🟨 Errores accesibles en formularios y animaciones reducibles |
| RNF-13 | SEO | Títulos y metadatos por página; conservar las URLs de Shopify | `<title>` y `meta description` únicos; redirecciones 301 desde las URLs antiguas | Lighthouse SEO ≥ 90 | 🟨 Títulos por página; faltan las redirecciones |
| RNF-14 | Localización | Español de Chile y CLP | Montos con `toLocaleString('es-CL')`, sin decimales (enteros en la BD); fechas en es-CL | Pruebas unitarias de formato | ✅ |

## Decisiones de arquitectura que responden a los RNF

- **RNF-03 / RNF-13 → SC-02:** se cambió Flutter Web por HTML/CSS/JS porque Flutter descarga ~1,5–2 MB de motor antes de mostrar contenido y renderiza en *canvas* (mal SEO).
- **RNF-04:** los pedidos se crean **solo** con `crear_pedido()` en el servidor (el navegador no decide precios ni descuentos) y el estado "pagado" lo marca **solo** el webhook con `service_role`.
- **RNF-06 / RNF-10 → SC-04:** por decisión del cliente se usa el plan gratuito de Supabase; su pausa por inactividad se evita con un ping programado y el respaldo diario automático se reemplaza por respaldos manuales.
- **RNF-14:** los montos se guardan como `integer` en CLP para evitar errores de redondeo.
