# Definición del Proyecto — Befine Store

**Grupo N3 · Plaxi Solutions · Capstone PTY4614 · Duoc UC Plaza Norte · Semestre 2026-2**
Integrantes: Iván Rodríguez Pinares · Carlos Fuentes González · Felipe Moraga López

> Documento de inicio del proyecto. Resume la Guía 1.5 (Informe APT Fase 1) y el Acta de Constitución v1.2 (09-oct-2026, en esta misma carpeta).

---

## 1. Problema

Agua Purificada Befine es una microempresa de distribución de agua purificada a domicilio en Quilicura (Santiago), con 5 años de operación, ~450 clientes activos y ~1.000 entregas mensuales. Su tienda opera sobre **Shopify**, lo que genera:

- **Costo recurrente** de suscripción SaaS y comisiones de plataforma.
- **Personalización limitada** de la experiencia de compra y de la gestión administrativa.
- **Información dispersa**: clientes y pedidos repartidos entre WhatsApp y la tienda, sin trazabilidad.
- **Dependencia del dueño**: la operación no se puede delegar porque no existe un panel propio con roles.

## 2. Objetivos

**Objetivo general.** Reducir los costos operativos, mejorar la experiencia de compra y habilitar la delegación de la operación de Befine mediante una plataforma de comercio electrónico web propia (mobile-first), que reemplace a Shopify e integre una tienda para el cliente y un panel de administración con pedidos, clientes, descuentos, fidelización por puntos, pago en línea y emisión automática de documentos tributarios electrónicos.

**Objetivos específicos**

1. Analizar y documentar los requisitos funcionales y no funcionales a partir de la operación actual en Shopify.
2. Diseñar la arquitectura de la solución y el modelo de datos relacional (catálogo, clientes, pedidos, puntos).
3. Desarrollar la tienda web (inicio, catálogo con variantes, quiénes somos) con HTML5/CSS3/JavaScript, mobile-first *(ajustado por SC-02; antes Flutter)*.
4. Desarrollar el panel de administración: pedidos y estados, envío por zona, clientes y descuentos, políticas e informes.
5. Implementar el sistema de fidelización por puntos y descuentos por metas.
6. Integrar Mercado Pago y la emisión automática de boletas/facturas con OpenFactura.
7. Validar la solución con pruebas funcionales y de integración, y desplegarla junto con su documentación técnica.

## 3. Stakeholders (interesados)

| Interesado | Rol | Interés principal | Influencia |
|---|---|---|---|
| Iván Rodríguez | Dueño de Befine, patrocinador e integrante | Plataforma confiable y delegable | Alta |
| Carlos Fuentes | Integrante (datos, programación, gestión) | Integridad de datos e informes | Alta |
| Felipe Moraga | Integrante (interfaz / frontend) | Usabilidad y consistencia visual | Alta |
| Docente guía Capstone | Evaluador del Proyecto APT | Cumplimiento metodológico y académico | Alta |
| Clientes de Befine (~450) | Usuarios finales | Compra simple, rápida y segura | Media |
| Personal de reparto (chofer) | Usuario del panel de pedidos | Ver pedidos y marcar entregas | Media |
| Mercado Pago / OpenFactura (Haulmer) | Proveedores externos | Integración correcta de sus APIs | Media |

## 4. Alcance del MVP

**Incluye**
- Tienda del cliente: inicio, catálogo con variantes, ficha de producto, carrito, checkout con despacho por zona, cuenta del cliente, contenido institucional y políticas.
- Pago en línea con Mercado Pago y emisión automática de boleta/factura (OpenFactura).
- Panel de administración: pedidos y estados, catálogo e inventario, clientes y segmentos (B2C/B2B), cupones generales y personales, zonas y tarifas de despacho, informes de venta, importación/exportación CSV.
- Roles: administrador (dueño), chofer (reparto) y cliente; el administrador puede crear roles nuevos y asignar permisos.
- Fidelización por puntos y canje de recompensas.
- Despliegue en producción contenerizado (Docker) y documentación técnica y de usuario.

**No incluye (fuera de alcance)**
- Aplicación móvil nativa (la cobertura móvil se entrega con web responsiva/PWA — SC-02).
- Integración con la API oficial de WhatsApp Business (en el MVP se usa enlace `wa.me` con mensaje prellenado).
- Logística avanzada (ruteo optimizado de reparto).

## 5. Restricciones

- **Plazo fijo:** 18 semanas (10-ago al 12-dic-2026), sin posibilidad de extensión.
- **Equipo:** 3 integrantes en modalidad vespertina (disponibilidad acotada).
- **Costo:** $508.795 CLP anuales en servicios (OpenFactura y certificado digital, con 15 % de contingencia), financiados por el cliente; Supabase en su plan gratuito por decisión del cliente (SC-04); sin cobro de horas-hombre (SC-01).
- **Tecnología:** frontend HTML5/CSS3/JavaScript sin licencias; backend Supabase (PostgreSQL); repositorio GitHub del equipo.
- **Normativa:** Ley 21.719 (protección de datos personales) y normativa SII para documentos tributarios electrónicos.

## 6. Justificación

- **Económica:** elimina la suscripción a Shopify; el costo anual de la nueva infraestructura es conocido y acotado.
- **Operacional:** centraliza pedidos y clientes, y permite delegar la operación mediante roles (admin/chofer).
- **Comercial:** mejor experiencia móvil, SEO y fidelización por puntos para retener a los ~450 clientes.
- **Académica:** moviliza las 4 competencias del perfil de egreso declaradas (pruebas, gestión de proyectos, modelos de datos y desarrollo de software) sobre un negocio real y medible.

## 7. Hitos

| Hito | Fecha | Estado al 09-oct-2026 |
|---|---|---|
| Aprobación del Acta de Constitución | 22-ago-2026 | ✅ Cumplido |
| Aprobación del Plan de Dirección del Proyecto | 19-sep-2026 | ✅ Cumplido (v1.2 el 09-oct por SC-01 a SC-04) |
| Informe de Avance Fase 2 | 12-oct-2026 | 🟨 En entrega |
| Fin de sprints de desarrollo | 14-nov-2026 | ⬜ Planificado |
| Go-Live (puesta en marcha) | 21-nov-2026 | ⬜ Planificado |
| Entrega final y presentación a comisión | 12-dic-2026 | ⬜ Planificado |
