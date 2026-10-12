# Sprint Backlog — Sprint 1

| Campo | Valor |
|---|---|
| **Sprint** | 1 de 4 (Fase de Ejecución) |
| **Fechas** | 21-sep-2026 → 04-oct-2026 (semanas 7–8) |
| **Scrum Master / líder de sprint** | Felipe Moraga |
| **Product Owner** | Iván Rodríguez |
| **Equipo de desarrollo** | Carlos Fuentes · Iván Rodríguez |
| **Repositorio de código** | github.com/IvnRP/befine-store — rama `ivan` (PR #19 hacia `main`) y `feature/CFG-04-github` |
| **Objetivo del sprint** | *Construir la base del frontend en HTML/CSS/JS tras la SC-02, con la tienda pública (inicio, catálogo y ficha) leyendo el catálogo real desde Supabase, la cuenta del cliente y la primera versión del checkout.* |
| **Informe de cierre** | [Informe_Sprint1_Befine_GrupoN3.docx](Informes_de_Sprint/Informe_Sprint1_Befine_GrupoN3.docx) |

## Historias y tareas

| ID | Tarea | Responsable | Estado al cierre |
|---|---|---|---|
| — | Sprint Planning, seguimiento diario, Sprint Review y retrospectiva; tablero y coordinación del equipo | Felipe Moraga (Scrum Master) | ✅ |
| **SC-02** | Solicitud de cambio Flutter → HTML/CSS/JS (aprobada el 22-sep) | Carlos Fuentes | ✅ |
| SC-02 | Retiro del proyecto Flutter del repositorio (27 archivos) — commit `46edfc7` | Iván Rodríguez | ✅ |
| — | Prototipo del inicio (escena según la hora, agua reactiva, saludo por franja) | Carlos Fuentes | ✅ |
| — | Maqueta navegable: inicio, catálogo y ficha, con barra y pie compartidos — commit `2686d31` | Iván Rodríguez | ✅ |
| **HU-02** | Catálogo, variantes y precios leídos desde Supabase (`data.js` como puente único; conexión del PR #18) | Carlos Fuentes / Iván Rodríguez | ✅ |
| **HU-04** | Carrito compartido entre páginas (cajón lateral, cantidades, acceso al pago) | Iván Rodríguez / Carlos Fuentes | ✅ En el navegador (guardarlo en la base pasa al S2) |
| **HU-01** | Registro, ingreso, recuperación y cambio de contraseña con Supabase Auth; panel del cliente — commit `a013028` | Iván Rodríguez | 🟨 Falta configurar el ingreso con Google |
| **HU-05 / HU-06** *(adelantadas del S2)* | Checkout en una página, como invitado o con cuenta: despacho por comuna, entrega estándar o agendada, boleta o factura | Iván Rodríguez | 🟨 Interfaz lista; pedido en demostración |
| **HU-03** | CRUD de productos (admin) | — | ⬜ No iniciada: se priorizó la tienda pública y la cuenta; se replanifica al S4 junto al resto del panel |
| **HU-15** | Reseñas reales de Google en el inicio (Edge Function `resenas-google`) | Iván Rodríguez | ✅ |
| — | Optimización de imágenes (WebP; logo de 652 KB a 85 KB) y modo ligero automático para celulares básicos | Iván Rodríguez | ✅ |
| **CFG-04** | Plantillas de issues y PR; README al stack de la SC-02 — commit `ec04bdb` | Iván Rodríguez | ✅ (rama sin integrar a `main`) |
| — | Validación de reglas de negocio: variantes con o sin bidón, precios y comunas | Iván Rodríguez (PO) | ✅ |

## Sprint Review (04-oct-2026)

- **Incremento demostrado:** tienda navegable con el catálogo real (11 productos, 12 variantes), carrito entre páginas, cuenta del cliente con Supabase Auth y checkout completo con despacho por comuna (pedido y pago en modo demostración).
- **Decisión del PO:** se acepta el incremento. Para el Sprint 2 se prioriza crear el pedido de forma segura en el servidor antes de conectar Mercado Pago, y definir los roles admin y chofer.

## Resultado

| Indicador | Valor |
|---|---|
| Historias del hito Sprint 1 terminadas | HU-02, HU-04 (carrito en el navegador) y HU-15 (reseñas de Google) |
| Historias parciales (continúan en el S2) | HU-01 (falta el ingreso con Google) |
| Historias no iniciadas (replanificadas) | HU-03 → Sprint 4 |
| Trabajo adelantado de otros sprints | Interfaz de HU-05 y HU-06 (checkout); panel del cliente (HU-18); saldo de puntos (HU-11) |
| Ítems técnicos terminados | SC-02, CFG-04 |
| Tamaño del incremento | 5 páginas HTML · 10 hojas CSS · 20 módulos JS · ≈ 4.380 líneas |
| Commits del sprint | 4 + 1 merge (rama `ivan`) |
