-- =====================================================================
-- BEFINE STORE · Carga de catálogo + cupón legacy (datos reales)
-- Grupo N3 · Capstone APT · 16-sep-2026
-- Ejecutar DESPUÉS del schema definitivo (befine_store_schema_DEFINITIVO.sql).
-- Precios = RETAIL (nivel 1). Los precios B2B (nivel 2) se cargan aparte.
-- =====================================================================

-- 1. Categorías
insert into public.categorias (nombre, slug) values
  ('Packs',         'packs'),
  ('Dispensadores', 'dispensadores'),
  ('Bidones',       'bidones'),
  ('Recargas',      'recargas')
on conflict (nombre) do nothing;

-- 2. Productos
insert into public.productos (categoria_id, nombre)
select c.id, x.nombre
from (values
  ('Pack Inicial — 4 Recargas de 12 Litros + Dispensador Soporte Blanco', 'Packs'),
  ('Pack Inicial — 3 Bidones de 20 Litros + Dispensador Soporte Blanco',  'Packs'),
  ('Dispensador Compresor Sobre Mesa',        'Dispensadores'),
  ('Dispensador Compresor con Bidón Oculto',  'Dispensadores'),
  ('Dispensador con Carga USB',               'Dispensadores'),
  ('Dispensador Compresor SIN Bidón Oculto',  'Dispensadores'),
  ('Dispensador Soporte Plástico Blanco',     'Dispensadores'),
  ('Bidón + Recarga 12 Litros',               'Bidones'),
  ('Bidón + Recarga 20 Litros',               'Bidones'),
  ('Recarga Bidón 12 Litros',                 'Recargas'),
  ('Recarga Bidón 20 Litros',                 'Recargas')
) as x(nombre, categoria)
join public.categorias c on c.nombre = x.categoria;

-- 3. Variantes (SKU generado; stock inicial de ejemplo = 100)
insert into public.variantes_producto (producto_id, sku, nombre, stock)
select p.id, v.sku, v.variante, 100
from (values
  ('Pack Inicial — 4 Recargas de 12 Litros + Dispensador Soporte Blanco', 'BEF-PACK-4REC12',  'Estándar'),
  ('Pack Inicial — 3 Bidones de 20 Litros + Dispensador Soporte Blanco',  'BEF-PACK-3BID20',  'Estándar'),
  ('Dispensador Compresor Sobre Mesa',        'BEF-DISP-MESA',      'Estándar'),
  ('Dispensador Compresor con Bidón Oculto',  'BEF-DISP-OCULTO',    'Estándar'),
  ('Dispensador con Carga USB',               'BEF-DISP-USB',       'Estándar'),
  ('Dispensador Compresor SIN Bidón Oculto',  'BEF-DISP-SINOCULTO', 'Estándar'),
  ('Dispensador Soporte Plástico Blanco',     'BEF-DISP-SOPORTE',   'Estándar'),
  ('Bidón + Recarga 12 Litros',               'BEF-BID-12',         'Estándar'),
  ('Bidón + Recarga 20 Litros',               'BEF-BID-20',         'Estándar'),
  ('Recarga Bidón 12 Litros',                 'BEF-REC-12',         'Estándar'),
  ('Recarga Bidón 20 Litros',                 'BEF-REC-20-BEFINE',  'Con bidón Befine'),
  ('Recarga Bidón 20 Litros',                 'BEF-REC-20-OTRA',    'Bidón de otra marca')
) as v(producto, sku, variante)
join public.productos p on p.nombre = v.producto;

-- 4. Precios RETAIL (nivel 1) — precio de venta actual, CLP
insert into public.precios_variante (variante_id, nivel_precio_id, precio)
select vp.id, 1, x.precio
from (values
  ('BEF-PACK-4REC12',    19990),
  ('BEF-PACK-3BID20',    21990),
  ('BEF-DISP-MESA',      70990),
  ('BEF-DISP-OCULTO',    159990),
  ('BEF-DISP-USB',       8990),
  ('BEF-DISP-SINOCULTO', 119990),
  ('BEF-DISP-SOPORTE',   8490),
  ('BEF-BID-12',         3990),
  ('BEF-BID-20',         5490),
  ('BEF-REC-12',         2000),
  ('BEF-REC-20-BEFINE',  2500),
  ('BEF-REC-20-OTRA',    2890)
) as x(sku, precio)
join public.variantes_producto vp on vp.sku = x.sku;

-- 5. Cupón LEGACY: 20% SOLO en la Recarga 20L con envase Befine
--    $2.500 - 20% = $2.000 exacto, compre 1 o compre 10.
insert into public.cupones (codigo, tipo, valor, compra_minima, combinable, activo)
values ('LEGACY2000', 'porcentaje', 20, 0, false, true)
on conflict (codigo) do nothing;

insert into public.cupon_variantes (cupon_id, variante_id)
select c.id, vp.id
from public.cupones c, public.variantes_producto vp
where c.codigo = 'LEGACY2000' and vp.sku = 'BEF-REC-20-BEFINE'
on conflict do nothing;

-- ---------------------------------------------------------------------
-- PENDIENTE (cuando tengas los datos):
--  - Precios B2B (nivel 2): repite el bloque 4 con nivel_precio_id = 2.
--  - Recompensas de puntos (catálogo de canje) — se definen en el panel admin.
-- ---------------------------------------------------------------------

-- FIN carga de catálogo
