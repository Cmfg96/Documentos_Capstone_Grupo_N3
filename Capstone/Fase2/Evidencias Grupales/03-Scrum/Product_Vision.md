# Product Vision — Befine Store

**Product Owner:** Iván Rodríguez (dueño de Agua Purificada Befine) · **Equipo:** Grupo N3 · **Versión:** 1.0 (09-oct-2026)

## Declaración de visión (elevator pitch)

> **Para** las familias, oficinas y empresas de la zona norte de Santiago que compran agua purificada a domicilio,
> **que** hoy compran por WhatsApp o en una tienda genérica sin seguimiento ni beneficios,
> **Befine Store** es **una tienda en línea propia, rápida y pensada para el celular**,
> **que** permite pedir la recarga en menos de un minuto, pagar en línea, recibir la boleta automáticamente, ver el estado del reparto y sumar puntos por cada compra.
> **A diferencia de** Shopify y otras plataformas genéricas,
> **nuestro producto** es del negocio: sin suscripción, con reglas propias (despacho por comuna, cupones personales, clientes empresa) y un panel donde el dueño delega la operación al equipo de reparto.

## Product Vision Board

| Grupo objetivo | Necesidades | Producto | Objetivos de negocio |
|---|---|---|---|
| **Cliente residencial** (familias de Quilicura y comunas vecinas) | Pedir la recarga rápido desde el celular; saber cuándo llega; no repetir sus datos | Tienda web mobile-first con checkout en una página, datos recordados y seguimiento del pedido | Eliminar la suscripción a Shopify tras el Go-Live |
| **Cliente empresa (B2B)** | Factura electrónica con su razón social; pedidos mínimos | Checkout con boleta o factura (RUT, razón social, giro) | ≥ 10 % de los ~450 clientes en el programa de puntos a 30 días del Go-Live |
| **Dueño (administrador)** | Ver ventas, gestionar pedidos, crear cupones, delegar | Panel de administración con roles y permisos configurables | Centralizar en un solo sistema los pedidos que hoy viven en WhatsApp |
| **Chofer (repartidor)** | Saber qué entregar y avisar al cliente | Vista de pedidos con botones "En camino" y "Entregado" que notifican por WhatsApp | Reducir llamadas de "¿cuándo llega?" |

## Atributos clave del producto

1. **Rápido:** compra en menos de 1 minuto; Lighthouse ≥ 90 y LCP ≤ 2,5 s en móvil.
2. **Propio:** sin licencias de plataforma; los datos del negocio viven en su base PostgreSQL.
3. **Seguro:** RLS en todas las tablas, pagos delegados a Mercado Pago (no se guardan tarjetas), Ley 21.719.
4. **Con identidad:** experiencia visual que cambia según la hora del día, agua que reacciona al tacto y saludo personalizado.
5. **Delegable:** roles y permisos configurables por el dueño (admin, chofer y nuevos roles).

## Fuera de la visión del MVP

App móvil nativa, ruteo optimizado de reparto e integración con la API oficial de WhatsApp Business (trabajo futuro).
