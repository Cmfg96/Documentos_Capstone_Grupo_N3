# Definition of Done (DoD) — Befine Store

**Versión:** 1.0 · **Vigente desde:** Sprint 2 (05-oct-2026) · **Fuente:** Plan de Gestión de la Calidad v1.1 (KPI y aseguramiento)

Una historia de usuario se considera **TERMINADA** solo si cumple **todos** los puntos que le aplican. El líder de sprint vigente lo verifica antes de moverla a "Done" en el tablero.

## 1. Nivel historia de usuario

| # | Criterio | Cómo se verifica |
|---|---|---|
| 1 | Cumple **todos sus criterios de aceptación** (Product Backlog) | Checklist en la issue de GitHub |
| 2 | El código está en la rama principal mediante **pull request revisado por otro integrante** | PR aprobado en GitHub |
| 3 | **Sin errores en la consola** del navegador en el flujo de la historia | DevTools en Chrome y Firefox |
| 4 | Funciona en **celular y computador** (360 px, 768 px y 1280 px) y en **tema claro y oscuro** — RNF-01 | Revisión visual |
| 5 | Accesibilidad básica: `alt` en imágenes, foco visible, campos con `label`, contraste AA — RNF-12 | Revisión manual + Lighthouse Accessibility ≥ 90 |
| 6 | Si toca datos: **políticas RLS** creadas o revisadas, sin permisos de escritura para `anon` — RNF-04 | Revisión de la migración SQL |
| 7 | Si cambia la base de datos: **migración versionada** con su **script de reversa** en `supabase/migrations/` | Archivos `*_reversa.sql` |
| 8 | Lógica de negocio (precios, despacho, puntos, validaciones) **con prueba unitaria** que pasa | `npm test` en verde |
| 9 | **Ninguna clave secreta** en el código (solo la clave pública *anon*; `service_role` y tokens en *secrets*) | Revisión del PR |
| 10 | Textos en español de Chile y montos en CLP sin decimales — RNF-14 | Revisión visual |
| 11 | Documentación actualizada si cambió algo visible (README, manual técnico o modelo de datos) | Revisión del PR |

## 2. Nivel sprint (incremento)

- Todas las historias comprometidas cumplen la DoD; las que no la cumplen **vuelven al Product Backlog** (no se dan por "casi listas").
- El incremento se **demuestra al Product Owner** (Iván Rodríguez) en la Sprint Review y él lo acepta o rechaza.
- Se registra la **retrospectiva** en `Retrospectivas/`.
- Se etiqueta la versión en Git (`v0.S.0`, por ejemplo `v0.2.0` al cierre del Sprint 2) — Plan de Gestión de la Configuración.

## 3. Nivel release (Go-Live, 21-nov-2026)

- 100 % de los casos de prueba críticos (pago, facturación y pedidos) ejecutados y aprobados.
- 0 errores críticos abiertos.
- Transacciones de prueba exitosas en el *sandbox* de Mercado Pago y en la certificación de OpenFactura.
- Lighthouse Performance ≥ 90 y LCP ≤ 2,5 s en móvil.
- Pruebas de aceptación de usuario (UAT) firmadas por el Product Owner.
- Manual técnico y manual de usuario entregados.
