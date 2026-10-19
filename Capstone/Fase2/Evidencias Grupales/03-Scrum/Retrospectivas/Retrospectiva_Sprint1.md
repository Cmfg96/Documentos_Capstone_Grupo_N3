# Retrospectiva — Sprint 1

| Campo | Valor |
|---|---|
| **Sprint** | 1 (21-sep → 04-oct-2026) |
| **Fecha** | 04-oct-2026 |
| **Facilitador (Scrum Master)** | Felipe Moraga |
| **Participantes** | Iván Rodríguez · Carlos Fuentes · Felipe Moraga |
| **Formato** | Qué funcionó / Qué no funcionó / Qué cambiamos |

## ✅ Qué funcionó (mantener)

- **Un solo puente de datos (`data.js`).** Las pantallas solo hablan con `window.Befine`; por eso pasar de datos de prueba a Supabase no obligó a tocar ninguna pantalla. Se mantiene este patrón para pedidos, pagos y el panel de administración.
- **Decidir la tecnología antes de construir.** La SC-02 se aprobó el segundo día hábil del sprint; el esqueleto en Flutter se descartó a los pocos días y el retrabajo fue mínimo.
- **Base de datos lista desde la Planificación (CFG-03).** El frontend trabajó con el catálogo real desde el primer día.
- **Rendimiento cuidado desde el inicio:** imágenes en WebP, logo reducido de 652 KB a 85 KB y modo ligero automático en celulares básicos.

## ⚠️ Qué no funcionó

| Situación | Efecto |
|---|---|
| La rama `main` siguió con el proyecto Flutter durante todo el sprint; el código nuevo vive en la rama `ivan` | `main` no refleja el producto real y las ramas personales se desfasan |
| El esqueleto en Flutter del PR #18 quedó obsoleto con la SC-02 | Trabajo descartado (la conexión a Supabase se rehízo en `data.js`) |
| El pedido y el pago quedaron en modo demostración | El checkout no crea pedidos reales; HU-05 y HU-06 siguen parciales |
| HU-03 (CRUD de productos) no se alcanzó | Se replanifica al Sprint 4 junto al resto del panel |
| La creación del pedido desde el navegador no era segura (montos decididos por el cliente) | Se detectó al revisar la base; requiere corrección antes de conectar Mercado Pago |
| Los commits del sprint quedaron concentrados en una sola cuenta | La evidencia de aporte individual en Git es desigual |

## 🚀 Qué cambiamos (acciones de mejora)

| Acción | Responsable | Plazo | Estado en Sprint 2 |
|---|---|---|---|
| Integrar el PR #19 a `main` al inicio del sprint y actualizar las ramas personales desde `main` antes de seguir | Iván Rodríguez / Felipe Moraga (revisión) | Inicio del S2 | 🟨 |
| Crear el pedido solo en el servidor antes de conectar Mercado Pago | Carlos Fuentes | S2 | ✅ (SC-03, `crear_pedido()`) |
| Definir roles admin y chofer en la base | Carlos Fuentes | S2 | ✅ (SC-03) |
| Cada integrante sube su trabajo con su propia cuenta y revisa los PR de otro | Todo el equipo | Continuo | 🟨 |
| Una issue por historia en GitHub Projects, actualizada en cada avance | Felipe Moraga | S2 | 🟨 |

## Lecciones aprendidas (registro PMBOK)

1. Separar el acceso a datos en un único archivo permite cambiar el origen de los datos sin tocar la interfaz.
2. Decidir la tecnología del frontend antes de construir evita retrabajo.
3. Integrar a `main` con frecuencia reduce el riesgo de ramas desfasadas.
4. Revisar la seguridad de la base antes de conectar pagos evita exponer los ingresos del negocio.
