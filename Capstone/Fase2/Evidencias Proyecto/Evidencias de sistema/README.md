# Evidencias de sistema — Befine Store (Fase 2)

**Grupo N3 · Capstone PTY4614 · Duoc UC Plaza Norte** · Secciones 1 a 5: Avance (09-oct-2026). Secciones 6 a 11: Entrega Final (15-oct al 18-nov-2026).

Evidencia del estado real de la **aplicación** y de la **base de datos** al cierre del Avance de Fase 2. La tienda se ejecutó con Docker (`docker compose up`) en `http://localhost:8080`, conectada a la base de datos Supabase de producción del proyecto. Las capturas con sufijo **a** son de escritorio y las con **b** son de celular (vista móvil de Chrome).

**Organización de esta carpeta:** `Aplicacion/capturas/` (pruebas, tienda web y Docker del Avance; subcarpetas `Sprint2/`, `Sprint3/` y `Sprint4/` de la Entrega Final), `Aplicacion/pruebas/` (pruebas automatizadas y defectos corregidos), `Aplicacion/gestion/` (repositorio, Kanban, PR, Lighthouse), `Aplicacion/Docker/` (archivos de despliegue), `Base de datos/SQL/` (scripts y migraciones) y `Base de datos/capturas/` (Supabase, migraciones y RLS). Son copias de `Evidencias Grupales/09-Evidencias-Sistema/`, `05-Diseno/SQL/` y `07-Operacion/Docker/`.

Código fuente: [IvnRP/befine-store](https://github.com/IvnRP/befine-store) · Detalle técnico: [Manual Técnico](../../Evidencias%20Grupales/07-Operacion/Manual_Tecnico.md) · Pruebas: [Plan de Pruebas](../../Evidencias%20Grupales/06-Calidad/Plan_de_Pruebas.md)

---

## 1. Pruebas automatizadas — `Aplicacion/capturas/`

| N° | Captura | Qué demuestra |
|---|---|---|
| 01 | `01_pruebas_npm_test_31_aprobadas.png` | `npm test` ejecutado en el equipo del desarrollador: **31 pruebas unitarias, 31 aprobadas, 0 fallidas**. Cubren carrito, despacho por comuna y envío gratis, días hábiles de entrega, validaciones (RUT, celular, correo, contraseña) y franjas horarias. Las pruebas cargan los mismos archivos JavaScript que usa el sitio. |

## 2. Aplicación (tienda web) — `Aplicacion/capturas/`

| N° | Captura | Qué demuestra |
|---|---|---|
| 02 / 03 | `02_inicio_escritorio.png` · `03_inicio_movil.png` | Página de inicio con el producto más pedido, selección de envase, cantidad y compra directa. Diseño *mobile-first*: la misma página se adapta al celular. |
| 04 | `04a_resenas_google_*` · `04b_…` | **Reseñas reales de Google** (5,0 · 17 reseñas) mostradas en la tienda. Se obtienen en vivo mediante la Edge Function `resenas-google` (ver 16), no son datos escritos a mano. |
| 05 | `05a_catalogo_*` · `05b_…` | Catálogo leído desde la base de datos: filtros por categoría, buscador, orden y precios de oferta. |
| 06 | `06a_ficha_producto_*` · `06b_…` | Ficha de producto con precio de oferta y precio anterior tachado, cantidad y botones de compra. El contador del carrito se actualiza. |
| 07 | `07a_carrito_*` · `07b_…` | Carrito lateral con 4 productos: cantidades, eliminar y total correcto (**$34.980** = 2.500 + 2.000 + 21.990 + 8.490). |
| 08 a / b | `08a_checkout_comunas_*` · `08b_…` | Checkout: lista de comunas con cobertura y su tarifa, leída desde las tablas `comunas_cobertura` y `zonas_despacho`. Entrega estándar calculada al siguiente día hábil (lunes 12-oct). |
| 08 c / d | `08c_checkout_envio_gratis_escritorio.png` · `08d_checkout_comuna_movil.png` | Regla de negocio **envío gratis desde $7.000**: Huechuraba tiene tarifa de $2.500, pero con un subtotal de $34.980 el despacho queda **Gratis** ("¡Tienes envío gratis!"). |
| 09 | `09a_checkout_error_rut_*` · `09b_…` | Validación en línea: el RUT 11.222.333-4 se rechaza porque su dígito verificador correcto es 9 (módulo 11). El error aparece bajo el campo y queda asociado a él para lectores de pantalla. |
| 10 | `10a_cuenta_login_*` · `10b_…` | Cuenta del cliente: ingreso con correo y contraseña (Supabase Auth), ingreso con Google, crear cuenta y recuperar contraseña. |
| 17 | `17a_inicio_modo_noche_*` · `17b_…` | **Innovación:** la tienda cambia escena, colores del agua y saludo según la hora del día (madrugada, día, tarde y noche). Comparar con 02 (modo día). |

## 3. Despliegue con Docker — `Aplicacion/capturas/` · `Aplicacion/Docker/`

| N° | Captura | Qué demuestra |
|---|---|---|
| 11 | `11a_docker_desktop_contenedor.png` · `11b_docker_desktop_contenedor_detalle.png` | Contenedor `befine-store` en ejecución (imagen `befine-store:local`, nginx, puerto **8080:80**), levantado con `docker compose up --build` a partir del `Dockerfile` y `docker-compose.yml` del repositorio. |

## 4. Base de datos (Supabase / PostgreSQL) — `Base de datos/capturas/`

Scripts en [`Base de datos/SQL/`](Base%20de%20datos/SQL): `01_befine_store_schema.sql` (21 tablas, funciones, triggers, índices y RLS), `02_befine_store_catalogo.sql` (catálogo real) y `03_migracion_20261009_01_seguridad_roles.sql` (roles, permisos y `crear_pedido()`).

| N° | Captura | Qué demuestra |
|---|---|---|
| 12 | `12_supabase_table_editor_productos.png` | Tablas del esquema `public` (catálogo, pedidos, pagos, documentos tributarios, puntos, cupones, roles y permisos, entre otras) y los 11 productos reales cargados. |
| 13 | `13a_supabase_schema_visualizer_parte1.png` · `13b_…parte2.png` | Diagrama del modelo de datos implementado: tablas, columnas, tipos, llaves primarias y relaciones. Coincide con el [Modelo de Datos](../../Evidencias%20Grupales/05-Diseno/Modelo_Datos_Befine_Store.md). |
| 14 | `14_supabase_auth_usuarios.png` | Autenticación de usuarios con Supabase Auth (proveedor correo). |
| 15 | `15_supabase_politicas_rls.png` | **Seguridad:** Row Level Security activo por tabla (botón *Disable RLS*) con políticas por rol, por ejemplo lectura pública del catálogo (`public`) y administración para usuarios autenticados (`authenticated`). |
| 16 | `16_supabase_edge_function_resenas_google.png` | Edge Function `resenas-google` desplegada: 6 invocaciones desde su despliegue y 0 errores. Las pocas llamadas confirman que la caché de 1 hora funciona, lo que mantiene la consulta a Google dentro de la cuota gratuita. |

---

## 5. Gestión, repositorio y calidad — `Aplicacion/gestion/`

> G09 y G11 (secretos y pruebas RLS) están en `Base de datos/capturas/`.

Capturas tomadas el 10-oct-2026.

| N° | Captura | Qué demuestra |
|---|---|---|
| G01–G02 | `G01_kanban_parte1.png` · `G02_kanban_parte2.png` | Tablero Kanban de GitHub Projects: 21 tarjetas (HU, CFG y SC-01 a SC-04) asignadas a los integrantes; 8 terminadas, 5 en curso y 8 pendientes, más los PR #19 y #24. |
| G03–G04 | `G03_milestones_abiertos.png` · `G04_milestones_cerrados.png` | Milestones por sprint: Sprint 0 y 1 cerrados al 100 %, Sprint 2 en curso (22 %), Sprints 3 y 4 planificados. |
| G05 | `G05_repositorio_estructura.png` | Repositorio de código (rama `ivan`): `web/`, `tests/`, `docker/` y archivos de configuración. |
| G06 | `G06_historial_commits.png` | Historial de commits con mensajes que referencian la historia (HU) o el cambio (SC). |
| G07 | `G07a…` a `G07d…` | Regla «Proteger main»: activa, sin excepciones, Pull Request obligatorio con 1 aprobación, sin borrado ni *force push*. |
| G08 | `G08a…` a `G08c…` | Pull Requests: el #19 queda bloqueado hasta ser aprobado; el #18 fue revisado, aprobado y unido por Carlos Fuentes (revisión cruzada). |
| G09 | `G09_supabase_secretos.png` | Secretos de la Edge Function guardados en Supabase (solo nombres; la clave nunca llega al navegador). |
| G10 | `G10_tienda_localhost_docker.png` | Tienda servida desde el contenedor Docker en `http://localhost:8080`. |
| G11 | `G11a…` · `G11b…` | Prueba de seguridad RLS como visitante anónimo: `pedidos` y `perfiles` devuelven 0 filas; `productos` devuelve los 11 del catálogo público. |
| G12 | `G12a…` a `G12d…` | Lighthouse en vista móvil. Inicio: 73 / 84 / 100 / 100 (LCP 3,0 s). Catálogo: 70 / 96 / 100 / 100 (LCP 3,2 s). La meta de rendimiento (≥ 90) aún no se cumple; la causa principal es el CLS (0,50), mejora planificada para el Sprint 4. |
| G13 | `G13_retrospectiva_sprint1.png` | Acta de la retrospectiva del Sprint 1. |

---

## Estado al 09-oct-2026 (Avance Fase 2)

Las capturas de las secciones 1 a 5 muestran el sistema al cierre del Avance. En ese momento el pago con Mercado Pago, el panel completo y las fotos de productos estaban en construcción. Todo eso quedó implementado y en producción en la Entrega Final (sección 6 en adelante). La boleta automática con OpenFactura se descartó por la situación financiera del cliente (SC-06).

---

# Entrega Final — Fase 2 (Sprints 2 a 4 y Go-Live)

Evidencias del 15-oct al 18-nov-2026. **La tienda está en producción desde el 17-nov-2026 en [aguabefine.cl](https://aguabefine.cl)**, publicada en Cloudflare Pages y conectada a Supabase. Los números de pedido anteriores al 17-nov corresponden a datos de prueba que se borraron antes del Go-Live (con respaldo).

## 6. Sprint 2 — Cuenta y pedido en el servidor — `Aplicacion/capturas/Sprint2/`

| Captura | Qué demuestra |
|---|---|
| `HU-01_ingreso_con_Google_panel_cliente_2026-10-15.png` | HU-01: ingreso con Google y panel del cliente. |
| `HU-06_pedido_11_creado_con_crear_pedido_2026-10-15.png` | HU-06 y SC-03: el pedido se crea solo con la función del servidor `crear_pedido()`, que recalcula precios y despacho. |

## 7. Sprint 3 — Pago e historial — `Aplicacion/capturas/Sprint3/`

| Carpeta | Capturas | Qué demuestra |
|---|---|---|
| `Pago_MercadoPago/` | `HU-09_01` a `HU-09_07` | HU-08 y HU-09: checkout, pago aprobado en Mercado Pago (ambiente de prueba), comprobante del pedido #19, vuelta a la tienda con "Pedido confirmado" y oferta de crear cuenta al invitado. |
| `Historial_Pedidos/` | `HU-18_01` a `HU-18_05` | HU-18: Mis pedidos vacío, lista, detalle, "Volver a pedir" y carrito con el precio vigente. |

## 8. Sprint 4 — Funcionalidades, publicación y Go-Live — `Aplicacion/capturas/Sprint4/`

| Carpeta | Qué demuestra |
|---|---|
| `Pago_punta_a_punta/` (`E2E_01` a `E2E_05`) | Prueba de punta a punta del pedido #28: pago aprobado, comprobante, confirmación automática por webhook (pedido "en preparación") y tienda con "¡Pedido confirmado!". |
| `Aceptacion_Terminos/` (`HU-25_01` a `05`) | HU-25 (Ley 21.719): sin marcar la casilla no se puede pagar; con la casilla se pasa a Mercado Pago y la base registra fecha y versión de la aceptación. |
| `Disponible_a_pedido/` (`01` a `03`) | HU-22: con stock 0 el producto se vende "a pedido" y el checkout aplaza la fecha de entrega. |
| `Fotos_productos/` (`01` a `09`) | Fotos reales en el bucket `productos` de Supabase Storage, en catálogo, ficha, carrito, checkout e inicio (escritorio y celular). |
| `Reparto_Chofer/` (`01` a `08`) | HU-16 y HU-17: vista del chofer, aviso "Entregado" por WhatsApp, corrección M-07 (entregados de hoy), secciones del panel, historial del pedido y aviso sin emojis (M-08). |
| `Correo_Confirmacion/` (`01` a `06`) | HU-10: correo de confirmación de compra con contenido legal, enviado desde pedidos@aguabefine.cl, y dominio verificado en Resend. |
| `Clientes/` (`01` y `02`) | HU-23 y CM-03: ficha de cliente bloqueado y checkout que rechaza su compra. |
| `Ping_Supabase/` | SC-04: flujo programado de GitHub Actions en verde que evita la pausa del plan gratuito. |
| `Publicacion_Cloudflare/` (`01` y `02`) | CM-04: tienda publicada en Cloudflare Pages; Mercado Pago vuelve solo a la tienda por HTTPS (pedido #50). |
| `Pago_produccion/` | Credenciales de producción de Mercado Pago activadas. |
| `Google_OAuth/` (`01` a `03`) | Aplicación de Google publicada "En producción": ingreso con una cuenta que no es de prueba y pantalla de consentimiento. |
| `Go_Live/` (`01` a `15`) | **Go-Live del 17-nov-2026:** limpieza de datos de prueba, DNS anterior (plan B), dominios activos con SSL, aguabefine.cl en producción, compra real del pedido #1 ($2.000), correo, comprobante, panel, venta en Mercado Pago, devolución total (costo final $0), pedido cancelado y correos de cuenta en español. |
| `Despacho_7000/` (`00`, `02`, `03`, `05` a `07`) | CM-05: antes (comunas con precio), checkout bajo $7.000 con despacho $2.500, checkout con envío gratis, y producción con la barra de avance y la página Cómo funciona. |
| `SEO/` (`01` a `06`) | Inicio actualizado, Google Search Console (sitemap enviado, inicio indexado, fichas con fragmentos válidos), Cloudflare Web Analytics activado y productos en el perfil de Google. |
| `Avisos_Pedidos/` | Edge Function `mp-webhook` publicada sin verificación JWT (la llama Mercado Pago), que confirma el pago y avisa al dueño. |

## 9. Pruebas y defectos corregidos — `Aplicacion/pruebas/`

| Captura | Qué demuestra |
|---|---|
| `PU_npm_test_32_de_32_aprobadas_2026-10-15.png` · `npm_test_78_de_78_*` · `npm_test_82_de_82_*` | Crecimiento de las pruebas unitarias automatizadas: 32 → 78 → 82 (hoy 138, todas en verde). |
| `M-01_consola_ANTES_…` · `M-01_consola_DESPUES_…` | M-01: antes se ofrecía un feriado (08-12) como día de entrega; después no. |
| `M-02_M-03/` | M-02: el checkout reutiliza el pedido pendiente (#23) y crea uno nuevo solo si cambia el contenido (#24). M-03: el botón de pago se reactiva al volver de Mercado Pago. |
| `M-05_Club_cuenta/` | M-05: texto del Club corregido en Mi cuenta (celular). |
| `Stock_sin_bloqueos/` | HU-22: imagen Docker construida y 78 de 78 pruebas en verde. |

## 10. Gestión en GitHub — `Aplicacion/gestion/GitHub/`

| Captura | Qué demuestra |
|---|---|
| `GitHub_Kanban_responsables_2026-10-09.png` | Tablero Kanban con responsables. |
| `GitHub_milestones_sprints_2026-10-09.png` | Milestones por sprint. |
| `GitHub_HU-02_issue_criterios_aceptacion.png` | Historia de usuario como issue con criterios de aceptación. |
| `HU-14_CI_01_PR30_descripcion.png` · `HU-14_CI_02_PR30_checks_aprobados.png` | HU-14: Pull Request #30 con la integración continua en verde ("Pruebas unitarias" e "Imagen Docker"). |

## 11. Base de datos: migraciones y seguridad — `Base de datos/`

**Scripts** en [`Base de datos/SQL/migraciones/`](Base%20de%20datos/SQL/migraciones): las 15 migraciones aplicadas en producción (01, 01b, 02 a 11, 14, 15 y 16), cada una con su reversa y su prueba en seco. Al 19-nov-2026 la base tiene 28 tablas, 54 políticas RLS y 13 permisos.

| Captura | Qué demuestra |
|---|---|
| `capturas/Migraciones/MIG-02_…` | Prueba en seco de la migración 02 (reparto y roles): T01 a T13 OK, entre ellas "el chofer no lee la tabla de pedidos (RLS)". |
| `MIG-03_05_…` | Prueba en seco T01 a T07 y aplicación de las migraciones 03 (invitados y confirmación de pago) y 05 (stock sin bloqueos). |
| `MIG-06_…` · `MIG-07_…` · `MIG-08_…` | Prueba en seco y aplicación de las migraciones 06 (aceptación de Términos), 07 (fotos) y 08 (Club Befine). |
| `MIG-09_…` · `MIG-10_…` · `MIG-11_…` | Pruebas en seco de reparto (M-07), avisos sin emojis (M-08) y correo de confirmación (sin envíos duplicados). |
| `MIG-14_…` | Migración 14 (clientes): T01 a T14 OK, entre ellas "el chofer no ve la lista de clientes" y "un cliente bloqueado no puede comprar". |
| `MIG-15_prueba_en_seco.txt` · `MIG-15_aplicada.png` | Migración 15 (despacho desde $7.000, CM-05): prueba en seco y aplicación. |
| `capturas/RLS/PS_RLS_cliente_no_ve_pedidos_ajenos_2026-10-17.png` · `HU-01_RLS_admin_befine_ve_pedido_ajeno_2026-10-17.png` | Prueba de seguridad RLS: un cliente no ve pedidos ajenos y el administrador sí. |

## Pendientes de evidencia

- Captura de `npm test` con las 138 pruebas.
- Lighthouse sobre aguabefine.cl (móvil y escritorio).
- Kanban final y Pull Request #55 fusionado.
- Aviso de pedido pagado al dueño (correo o sonido en el panel).
