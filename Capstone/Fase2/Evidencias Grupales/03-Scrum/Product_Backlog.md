# Product Backlog — Befine Store

**Product Owner:** Iván Rodríguez · **Actualizado:** 09-oct-2026 (Sprint 2) · **Tablero:** GitHub Issues y Projects de [IvnRP/befine-store](https://github.com/IvnRP/befine-store/issues) (etiquetas `tipo:historia`, `area:*`, `P1/P2/P3`; hitos `Sprint 1`–`Sprint 4`)

Cada historia de usuario (HU) es una *issue* del repositorio de código y se traza a uno o más requerimientos funcionales (RF) y a un paquete de la EDT. Los RNF son transversales y se verifican con la [Definition of Done](Definition_of_Done.md).

- **HU-01 a HU-15:** historias del tablero Kanban (issues #2 a #17; la HU-15, reseñas de Google, es la issue #23 creada en el Sprint 1).
- **HU-16 a HU-31:** historias agregadas en el Sprint 2 al refinar el backlog, para que los 25 RF queden cubiertos (por crear como issues).

**Prioridad:** **P1** = bloqueante del MVP · **P2** = núcleo del MVP · **P3** = valor agregado.
**Estado:** ✅ Terminada · 🟨 Parcial / en curso · ⬜ Pendiente.

## Resumen al 09-oct-2026

| Prioridad | Historias | Terminadas | Parciales / en curso | Pendientes |
|---|---|---|---|---|
| P1 | 10 | 2 | 4 | 4 |
| P2 | 12 | 1 | 4 | 7 |
| P3 | 9 | 1 | 1 | 7 |
| **Total** | **31** | **4** | **9** | **18** |

## Historias del tablero Kanban (issues #2–#17 y #23)

| ID | Historia (issue) | Como… quiero… para… | Criterios de aceptación | RF | Prio. | Sprint | Estado |
|---|---|---|---|---|---|---|---|
| **HU-01** | Registro e inicio de sesión de cliente (#2) | Como **visitante** quiero **crear una cuenta e ingresar** para **guardar mis datos, ver mis pedidos y sumar puntos**. | • Registro con nombre, correo, celular y contraseña con medidor de seguridad · • Confirmación por correo · • Ingreso, recuperación y cambio de contraseña · • Aceptación de términos (Ley 21.719) · • Ingreso con Google | RF-01, RF-02 | P1 | 1 | 🟨 (falta configurar el ingreso con Google) |
| **HU-02** | Catálogo y ficha de producto | Como **cliente** quiero **explorar el catálogo y elegir la variante** para **comprar exactamente lo que necesito**. | • Grilla desde Supabase con filtro por categoría, búsqueda sin tildes y orden por precio · • Ficha con precio por variante, oferta y cantidad | RF-03, RF-04 | P1 | 1 | ✅ |
| **HU-03** | CRUD de productos (admin) (#6) | Como **admin** quiero **crear y editar productos, variantes y precios** para **mantener el catálogo sin un desarrollador**. | • CRUD con permiso `catalogo.gestionar` · • Activo/borrador · • Imágenes y descripción | RF-17 | P2 | 1 → 4 | ⬜ (no se alcanzó en el S1; se replanifica al S4, con el resto del panel) |
| **HU-04** | Carrito de compras | Como **cliente** quiero **un carrito que se mantenga entre páginas** para **revisar mi compra antes de pagar**. | • Cajón lateral con cantidades y subtotal · • Se conserva al navegar y recargar · • Con sesión, se guarda en `carritos` / `items_carrito` | RF-05 | P1 | 1–2 | ✅ (en el navegador; guardarlo en la base es tarea del S2) |
| **HU-05** | Registrar dirección de despacho (#8) | Como **cliente** quiero **ingresar mi dirección y que se valide la cobertura** para **saber cuánto cuesta el despacho**. | • Comunas con cobertura y tarifa · • Despacho gratis desde el mínimo configurado · • La dirección se guarda en `direcciones` para la próxima compra | RF-06 | P1 | 2 | 🟨 (cálculo listo en el checkout; falta guardar la dirección) |
| **HU-06** | Confirmar y crear pedido (#9) | Como **cliente** quiero **confirmar mi compra y que el pedido quede registrado** para **que Befine lo prepare**. | • El pedido se crea solo con `crear_pedido()` en el servidor · • Entrega estándar o agendada en día hábil · • Boleta o factura (RUT, razón social, giro) · • El pedido nace en `pendiente_pago` | RF-06, RF-08 | P1 | 2 | 🟨 (función del servidor lista con la SC-03; falta conectar el checkout) |
| **HU-07** | Panel de pedidos con estados (admin) (#10) | Como **admin** quiero **ver y gestionar los pedidos y sus estados** para **despachar a tiempo**. | • Lista con filtros por estado, fecha y cliente · • Detalle y cronología auditable (RNF-09) · • Solo con permiso `pedidos.ver` / `pedidos.gestionar` | RF-16 | P1 | 2 → 3 | ⬜ (permisos y RLS listos con la SC-03; la pantalla va en el S3) |
| **HU-08** | Pago con Mercado Pago (#11) | Como **cliente** quiero **pagar con Mercado Pago** para **pagar seguro sin entregar mi tarjeta a la tienda**. | • Edge Function crea la preferencia · • Redirección y regreso a la tienda · • No se guardan datos de tarjeta | RF-07 | P1 | 3 | ⬜ (hoy es una simulación) |
| **HU-09** | Webhook de confirmación de pago (#12) | Como **dueño** quiero que **el pago se confirme automáticamente** para **despachar solo pedidos pagados**. | • Consulta el pago a la API de MP · • Solo si el monto coincide: `pagado → en_preparacion` · • Descuenta stock · • Idempotente | RF-07 | P1 | 3 | ⬜ (migración 03 escrita) |
| **HU-10** | Emitir boleta / factura vía OpenFactura (#13) | Como **cliente** quiero **recibir mi boleta o factura automáticamente** para **no tener que pedirla**. | • Emisión al confirmarse el pago · • PDF disponible para el cliente y el admin · • Probada en certificación SII | RF-08 | P2 | 3 | ⬜ |
| **HU-11** | Acumular puntos por compra (#14) | Como **cliente** quiero **sumar puntos por cada compra pagada** para **obtener beneficios**. | • Los puntos se suman al confirmarse el pago · • Saldo visible en "Mi cuenta" | RF-11 | P3 | 4 | ⬜ (el saldo ya se muestra; la suma va con el webhook) |
| **HU-12** | Canjear puntos en un pedido (#15) | Como **cliente** quiero **canjear mis puntos como descuento** para **pagar menos**. | • Canje en el checkout según las reglas del admin · • Validado en el servidor | RF-11 | P3 | 4 | ⬜ |
| **HU-13** | Dashboard de ventas y clientes (admin) (#16) | Como **admin** quiero **ver ventas, pedidos y clientes por período** para **tomar decisiones**. | • Filtro diario, semanal, mensual y anual · • Montos en CLP | RF-15 | P2 | 4 | ⬜ |
| **HU-14** | Docker y manual de despliegue (#17) | Como **equipo** queremos **levantar la tienda con un comando y documentar el despliegue** para **instalarla igual en cualquier equipo y en producción**. | • Dockerfile + docker-compose · • `.env.example` · • Manual técnico de instalación y despliegue | RNF-11 (EDT 7.1, 8.1) | P2 | 4 → 2 | ✅ (Dockerfile, docker-compose, manual técnico v0.2 y 31 pruebas automatizadas) |
| **HU-15** | Reseñas reales de Google en el inicio (#23) | Como **visitante** quiero **ver reseñas reales de Google en el inicio** para **confiar en la tienda**. | • Calificación y reseñas desde Google Places · • Caché de 1 hora (costo cero) · • La clave de Google nunca llega al navegador | RF-12 | P3 | 1 | ✅ |

## Historias agregadas en el Sprint 2 (por crear como issues)

| ID | Historia | Como… quiero… para… | Criterios de aceptación | RF | Prio. | Sprint | Estado |
|---|---|---|---|---|---|---|---|
| **HU-16** | Vista del chofer | Como **chofer** quiero **ver mis entregas y marcar "En camino" y "Entregado"** para **cerrar el ciclo de reparto**. | • Solo `en_preparacion → en_ruta → entregado` · • Cada cambio queda con chofer y hora | RF-16 | P1 | 3 | ⬜ (migración 02 escrita) |
| **HU-17** | Avisos por WhatsApp | Como **cliente** quiero **un aviso por WhatsApp cuando mi pedido va en camino y cuando se entrega** para **saber cuándo llega**. | • Mensaje con los datos del pedido · • Se dispara desde la vista del chofer | RF-09 | P2 | 3 | ⬜ |
| **HU-18** | Historial de pedidos del cliente | Como **cliente** quiero **ver mis pedidos y su estado** para **hacer seguimiento y repetir compras**. | • Lista con estado, total y fecha · • Detalle con productos y documento · • Solo los propios (RLS) | RF-10 | P2 | 2 | 🟨 (panel listo con pedidos de demostración) |
| **HU-19** | Compra como invitado | Como **visitante** quiero **comprar sin cuenta y crearla al final** para **no perder tiempo pero sumar los puntos de esa compra**. | • Checkout sin cuenta · • Al final ofrece crearla mostrando los puntos · • El pedido queda en la cuenta nueva | RF-01, RF-11 | P2 | 3 | 🟨 (interfaz lista; migración 03 escrita) |
| **HU-20** | Cupones generales y personales | Como **admin** quiero **crear cupones para todos o para un cliente** para **promocionar y fidelizar**. | • Monto fijo o porcentaje, mínimo, vigencia y usos · • Validados en el servidor | RF-20 | P2 | 2 → 4 | 🟨 (validación en el servidor lista; pantalla en S4) |
| **HU-21** | Zonas y tarifas de despacho (admin) | Como **admin** quiero **configurar comunas, tarifas y el mínimo para envío gratis** para **cobrar bien el despacho**. | • CRUD de zonas y comunas · • El checkout usa la configuración vigente | RF-21 | P2 | 4 | 🟨 (el checkout ya lee la base) |
| **HU-22** | Inventario | Como **admin** quiero **controlar el stock** para **no vender lo que no tengo**. | • Stock editable · • Descuento automático al confirmar el pago | RF-18 | P2 | 4 | ⬜ |
| **HU-23** | Clientes y empresas (B2B) | Como **admin** quiero **gestionar clientes y distinguir empresas** para **atenderlos según su tipo**. | • Ficha con historial y monto gastado · • Mínimo de compra B2B | RF-19 | P2 | 4 | ⬜ |
| **HU-24** | Informes exportables | Como **admin** quiero **informes de ventas e inventario en CSV** para **controlar el negocio**. | • Rango de fechas · • Exportación CSV | RF-24 | P2 | 4 | ⬜ |
| **HU-25** | Contenido institucional y políticas | Como **visitante** quiero **ver quiénes somos, cómo funciona, zonas y políticas** para **confiar en la tienda**. | • Quiénes somos, cómo funciona y zonas · • Políticas legales publicadas | RF-12 | P3 | 1–4 | 🟨 (inicio y zonas listos; faltan políticas; las reseñas son la HU-15) |
| **HU-26** | El dueño edita la tienda | Como **dueño** quiero **editar textos, destacados, ofertas e imágenes desde el panel** para **no depender de un desarrollador**. | • Producto protagonista, "Lo más pedido", precios tachados y textos editables | RF-23 | P3 | 4 | ⬜ |
| **HU-27** | Contacto y WhatsApp | Como **visitante** quiero **un formulario de contacto y un botón de WhatsApp** para **resolver dudas**. | • Nombre y correo obligatorios · • El mensaje llega al admin | RF-13 | P3 | 4 | ⬜ |
| **HU-28** | Suscripción a novedades | Como **visitante** quiero **suscribirme a novedades** para **recibir ofertas**. | • Valida el correo y evita duplicados | RF-14 | P3 | 4 | ⬜ |
| **HU-29** | Medios de pago configurables | Como **admin** quiero **activar o desactivar medios de pago** para **controlar cómo cobro**. | • Mercado Pago o transferencia · • Credenciales como *secrets* | RF-22 | P3 | 4 | ⬜ |
| **HU-30** | Importar desde Shopify | Como **admin** quiero **importar y exportar productos y clientes en CSV** para **migrar desde Shopify**. | • Importa el CSV de Shopify · • Valida en prueba antes de guardar (R6) | RF-25 | P3 | 4 | ⬜ |
| **HU-31** | Roles y permisos configurables | Como **dueño** quiero **roles admin y chofer, y poder crear roles nuevos** para **delegar sin exponer el negocio**. | • Admin con acceso total y único que gestiona roles · • Chofer solo ve pedidos pagados · • 12 permisos asignables · • El usuario nunca elige su rol | RF-02 | P1 | 2 | 🟨 (base de datos lista con la SC-03; pantalla de gestión en S4) |

## Ítems de configuración y cambio (issues)

| ID | Ítem | Sprint | Estado |
|---|---|---|---|
| CFG-03 | Base de datos en Supabase: 21 tablas con RLS y catálogo real | Planificación (16-sep) | ✅ |
| SC-02 | Cambio de frontend Flutter → HTML/CSS/JS (#21) | 1 | ✅ aprobado e implementado (cerrar la issue) |
| CFG-04 | Repositorio institucional y automatización de GitHub: plantillas de issues y PR, README (#22) | 1 | ✅ (rama por integrar a `main`) |
| SC-03 | Seguridad de pedidos y roles configurables (migración 01) | 2 | ✅ |
| SC-04 | Plan gratuito de Supabase (decisión del cliente) | 2 | 🟨 |
| CFG-06 | Integrar el PR #19 (rama `ivan`) y la rama de CFG-04 a `main` | 2 | 🟨 |

## Matriz de trazabilidad RF → HU

| RF | HU | RF | HU | RF | HU |
|---|---|---|---|---|---|
| RF-01 | HU-01, HU-19 | RF-10 | HU-18 | RF-19 | HU-23 |
| RF-02 | HU-01, HU-31 | RF-11 | HU-11, HU-12, HU-19 | RF-20 | HU-20 |
| RF-03 | HU-02 | RF-12 | HU-15, HU-25 | RF-21 | HU-21 |
| RF-04 | HU-02 | RF-13 | HU-27 | RF-22 | HU-29 |
| RF-05 | HU-04 | RF-14 | HU-28 | RF-23 | HU-26 |
| RF-06 | HU-05, HU-06 | RF-15 | HU-13 | RF-24 | HU-24 |
| RF-07 | HU-08, HU-09 | RF-16 | HU-07, HU-16 | RF-25 | HU-30 |
| RF-08 | HU-06, HU-10 | RF-17 | HU-03 | | |
| RF-09 | HU-17 | RF-18 | HU-22 | | |

Los 25 RF quedan cubiertos por al menos una historia.
