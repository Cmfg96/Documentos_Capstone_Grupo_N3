# Evidencias de sistema — Befine Store (Avance Fase 2)

**Grupo N3 · Capstone PTY4614 · Duoc UC Plaza Norte** · Capturas tomadas el 09-oct-2026 (Sprint 2)

Evidencia del estado real de la **aplicación** y de la **base de datos** al cierre del Avance de Fase 2. La tienda se ejecutó con Docker (`docker compose up`) en `http://localhost:8080`, conectada a la base de datos Supabase de producción del proyecto. Las capturas con sufijo **a** son de escritorio y las con **b** son de celular (vista móvil de Chrome).

Código fuente: [IvnRP/befine-store](https://github.com/IvnRP/befine-store) · Detalle técnico: [Manual Técnico](../07-Operacion/Manual_Tecnico.md) · Pruebas: [Plan de Pruebas](../06-Calidad/Plan_de_Pruebas.md)

---

## 1. Pruebas automatizadas

| N° | Captura | Qué demuestra |
|---|---|---|
| 01 | `01_pruebas_npm_test_31_aprobadas.png` | `npm test` ejecutado en el equipo del desarrollador: **31 pruebas unitarias, 31 aprobadas, 0 fallidas**. Cubren carrito, despacho por comuna y envío gratis, días hábiles de entrega, validaciones (RUT, celular, correo, contraseña) y franjas horarias. Las pruebas cargan los mismos archivos JavaScript que usa el sitio. |

## 2. Aplicación (tienda web)

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

## 3. Despliegue con Docker

| N° | Captura | Qué demuestra |
|---|---|---|
| 11 | `11a_docker_desktop_contenedor.png` · `11b_docker_desktop_contenedor_detalle.png` | Contenedor `befine-store` en ejecución (imagen `befine-store:local`, nginx, puerto **8080:80**), levantado con `docker compose up --build` a partir del `Dockerfile` y `docker-compose.yml` del repositorio. |

## 4. Base de datos (Supabase / PostgreSQL)

| N° | Captura | Qué demuestra |
|---|---|---|
| 12 | `12_supabase_table_editor_productos.png` | Tablas del esquema `public` (catálogo, pedidos, pagos, documentos tributarios, puntos, cupones, roles y permisos, entre otras) y los 11 productos reales cargados. |
| 13 | `13a_supabase_schema_visualizer_parte1.png` · `13b_…parte2.png` | Diagrama del modelo de datos implementado: tablas, columnas, tipos, llaves primarias y relaciones. Coincide con el [Modelo de Datos](../05-Diseno/Modelo_Datos_Befine_Store.md). |
| 14 | `14_supabase_auth_usuarios.png` | Autenticación de usuarios con Supabase Auth (proveedor correo). |
| 15 | `15_supabase_politicas_rls.png` | **Seguridad:** Row Level Security activo por tabla (botón *Disable RLS*) con políticas por rol, por ejemplo lectura pública del catálogo (`public`) y administración para usuarios autenticados (`authenticated`). |
| 16 | `16_supabase_edge_function_resenas_google.png` | Edge Function `resenas-google` desplegada: 6 invocaciones desde su despliegue y 0 errores. Las pocas llamadas confirman que la caché de 1 hora funciona, lo que mantiene la consulta a Google dentro de la cuota gratuita. |

---

## 5. Gestión, repositorio y calidad (carpeta `gestion/`)

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

## Estado y pendientes (transparencia)

- **Pago y pedidos:** la compra llega hasta el checkout validado. La creación del pedido en el servidor, el pago con Mercado Pago y la emisión de boleta/factura con OpenFactura se construyen en los Sprints 3 y 4, por lo que no aparecen en estas capturas.
- **Panel de administración:** el panel de pedidos (HU-07) se construye en el Sprint 3 y el panel completo (HU-03) en el Sprint 4.
- **Imágenes de producto:** las tarjetas muestran un fondo azul porque `imagen_url` aún está vacío en la base de datos (ver 12). Se cargarán las fotos antes de la entrega final.
- El pie de página del sitio dice "datos y colores de demostración". Es un texto de la etapa de maqueta que se actualizará: los productos, precios, comunas y reseñas que muestran estas capturas son reales.
