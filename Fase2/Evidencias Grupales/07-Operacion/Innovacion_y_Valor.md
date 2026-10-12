# Innovación y propuesta de valor — Befine Store

## 1. ¿Qué problema resuelve?

Una microempresa real de reparto de agua (≈ 450 clientes, ≈ 1.000 entregas al mes) depende de **Shopify** (costo mensual y poca personalización) y de **WhatsApp** (pedidos sin registro ni trazabilidad). El dueño no puede delegar la operación porque todo pasa por él.

Befine Store reemplaza ambas cosas por **una plataforma propia** que cobra, factura, avisa al cliente y deja que el chofer cierre el ciclo de entrega, sin pagar una suscripción de plataforma.

## 2. ¿Qué lo hace diferente?

| # | Innovación | Por qué importa | Evidencia |
|---|---|---|---|
| 1 | **Experiencia que cambia con la hora del día.** El inicio muestra una escena distinta (madrugada, día, tarde y noche), cambia los colores del agua y saluda según la hora ("Buenas tardes…"); a un cliente que vuelve lo saluda con un mensaje de regreso. | Hace que una compra rutinaria (una recarga de agua) se sienta cercana y de la marca, no de una plantilla genérica. | `js/bands.js`, `js/scenes.js` + 9 pruebas en `tests/unit/horario.test.js` |
| 2 | **Agua que reacciona al puntero y al tacto**, con ajuste automático del rendimiento según el dispositivo y respeto por `prefers-reduced-motion`. | Diferencia visual sin sacrificar la velocidad en celulares de gama baja ni la accesibilidad. | `js/water.js`, `js/perf.js` |
| 3 | **Compra en menos de 1 minuto**: checkout en una sola página, datos recordados, validación chilena en línea (RUT, celular), despacho calculado por comuna y entrega agendada en días hábiles. | El cliente típico repite la misma compra; cada paso extra es un pedido que se va a WhatsApp. | `checkout.html`, `forms.js` + pruebas |
| 4 | **Cierre del ciclo de reparto por WhatsApp**: el chofer pulsa "En camino" y "Entregado", y el cliente recibe el aviso en el canal que ya usa. | Elimina las llamadas de "¿cuándo llega?" y deja trazabilidad de cada entrega (RNF-09). | Migración `02_reparto_whatsapp` + diagrama de secuencia |
| 5 | **Fidelización con cupones personales**: puntos por compra, recompensas y cupones que solo funcionan para un cliente específico (por ejemplo, para respetar el precio histórico de un cliente antiguo). | Retiene a la base de clientes existente sin crear listas de precios por cliente. | Migración 01 (`cupones.perfil_id`) |
| 6 | **Seguridad del dinero en el servidor**: el navegador no decide precios, descuentos ni pagos; los pedidos se crean con `crear_pedido()` y el pago lo confirma solo el webhook, de forma idempotente. | Una tienda propia no puede ser más vulnerable que Shopify. | `Arquitectura.md` §4 |
| 7 | **Roles configurables por el dueño (RBAC)**: además de admin y chofer, el dueño puede crear roles y asignarles permisos sin tocar código. | Habilita la delegación real a medida que el negocio crece. | Tablas `roles`, `permisos` y `rol_permisos` |
| 8 | **Boleta/factura automática** con OpenFactura al confirmarse el pago, para clientes residenciales y empresas. | Elimina la emisión manual de documentos tributarios. | HU-10 (Sprint 3) |
| 9 | **Reseñas reales de Google con costo cero**: una Edge Function con caché de 1 hora mantiene las consultas muy por debajo del tramo gratuito. | Prueba social auténtica sin costo recurrente. | `functions/resenas-google` |

## 3. Valor agregado medible

| Indicador | Línea base (Shopify) | Meta con Befine Store |
|---|---|---|
| Suscripción de plataforma | Pago mensual | $0 (se elimina tras el Go-Live) |
| Costo anual de infraestructura y servicios | — | $508.795 CLP con 15 % de contingencia (SC-01, SC-04); Supabase en plan gratuito |
| Tiempo de compra en móvil | Varios pasos | ≤ 1 minuto |
| Rendimiento móvil | — | Lighthouse ≥ 90, LCP ≤ 2,5 s |
| Clientes en el programa de puntos | 0 | ≥ 10 % de ~450 a 30 días del Go-Live |
| Emisión de documentos tributarios | Manual | Automática |
