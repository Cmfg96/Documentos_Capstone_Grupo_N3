# Diagramas UML — Befine Store

**Versión:** 1.0 (09-oct-2026). Los diagramas están en **Mermaid** y se dibujan directamente en GitHub.

Contenido: 1) Casos de uso · 2) Clases del dominio · 3) Secuencia: compra y pago · 4) Secuencia: reparto y aviso por WhatsApp · 5) Estados del pedido · 6) Componentes.

---

## 1. Diagrama de casos de uso

Actores: **Visitante/Cliente**, **Administrador**, **Chofer** y los sistemas externos **Mercado Pago** y **OpenFactura**.

```mermaid
flowchart LR
  C(["👤 Cliente"])
  A(["👤 Administrador"])
  CH(["👤 Chofer"])
  MP[["Mercado Pago"]]
  OF[["OpenFactura"]]

  subgraph Tienda["Befine Store — Tienda"]
    UC1([Registrarse / iniciar sesión])
    UC3([Explorar catálogo])
    UC4([Ver ficha y elegir variante])
    UC5([Gestionar carrito])
    UC6([Realizar checkout por zona])
    UC7([Pagar en línea])
    UC8([Recibir boleta/factura])
    UC10([Ver historial de pedidos])
    UC11([Acumular y canjear puntos])
    UC20([Aplicar cupón])
  end

  subgraph Panel["Befine Store — Panel de administración"]
    UC15([Ver dashboard de ventas])
    UC16([Gestionar pedidos])
    UC16b([Marcar En camino / Entregado])
    UC17([Gestionar catálogo e inventario])
    UC19([Gestionar clientes])
    UC20b([Gestionar cupones])
    UC21([Configurar zonas y tarifas])
    UC24([Generar informes])
    UCR([Gestionar roles y permisos])
  end

  C --- UC1 & UC3 & UC4 & UC5 & UC6 & UC10 & UC11
  UC6 -. include .-> UC7
  UC6 -. extend .-> UC20
  UC7 -. include .-> UC8
  UC7 --- MP
  UC8 --- OF

  A --- UC15 & UC16 & UC17 & UC19 & UC20b & UC21 & UC24 & UCR
  CH --- UC16b
  UC16b -. extend .-> UC16
```

| Caso de uso | RF | Actor principal | Precondición | Postcondición |
|---|---|---|---|---|
| Realizar checkout por zona | RF-06 | Cliente | Carrito con al menos 1 ítem | Pedido en `pendiente_pago` creado por `crear_pedido()` |
| Pagar en línea | RF-07 | Cliente / Mercado Pago | Pedido en `pendiente_pago` | Pago `aprobado` y pedido en `en_preparacion` |
| Recibir boleta/factura | RF-08 | OpenFactura | Pago aprobado | DTE `emitido` y PDF disponible |
| Marcar En camino / Entregado | RF-09, RF-16 | Chofer | Pedido `en_preparacion` o `en_ruta` | Estado actualizado, historial registrado, aviso por WhatsApp |
| Gestionar roles y permisos | RF-02 | Administrador | Sesión con rol admin | Rol nuevo con sus permisos |

---

## 2. Diagrama de clases (modelo de dominio)

Vista conceptual de las entidades principales del [modelo de datos](Modelo_Datos_Befine_Store.md) (21 tablas + roles y permisos) y sus operaciones de negocio.

```mermaid
classDiagram
  direction LR
  class Perfil {
    +uuid id
    +string nombre
    +string telefono
    +string rol
    +bool es_empresa
    +int puntos
    +tienePermiso(codigo) bool
  }
  class Rol {
    +string id
    +string nombre
    +bool es_sistema
  }
  class Permiso {
    +string codigo
    +string modulo
  }
  class Producto {
    +int id
    +string nombre
    +bool activo
  }
  class Variante {
    +int id
    +string sku
    +int stock
    +precio(nivel) int
  }
  class Pedido {
    +uuid id
    +int numero
    +EstadoPedido estado
    +int subtotal
    +int costo_despacho
    +int descuento
    +int total
    +date fecha_entrega
    +crear(items, direccion, cupon)$ Pedido
    +marcarReparto(estado)
  }
  class DetallePedido {
    +int cantidad
    +int precio_unitario
  }
  class Pago {
    +string mp_payment_id
    +EstadoPago estado
    +int monto
    +confirmar()
  }
  class DocumentoTributario {
    +TipoDTE tipo
    +int folio
    +EstadoDTE estado
    +emitir()
  }
  class Cupon {
    +string codigo
    +TipoDescuento tipo
    +int valor
    +uuid perfil_id
    +esValidoPara(perfil, subtotal) bool
  }
  class MovimientoPuntos {
    +TipoMov tipo
    +int puntos
  }
  class ZonaDespacho {
    +string nombre
    +int costo_despacho
  }
  class Comuna {
    +string comuna
  }
  class HistorialPedido {
    +estado_anterior
    +estado_nuevo
    +timestamp fecha
  }

  Perfil "*" --> "1" Rol
  Rol "*" -- "*" Permiso
  Producto "1" *-- "1..*" Variante
  Perfil "1" --> "*" Pedido : realiza
  Pedido "1" *-- "1..*" DetallePedido
  DetallePedido "*" --> "1" Variante
  Pedido "1" --> "0..*" Pago
  Pedido "1" --> "0..1" DocumentoTributario
  Pedido "*" --> "0..1" Cupon
  Pedido "*" --> "1" ZonaDespacho
  ZonaDespacho "1" *-- "*" Comuna
  Perfil "1" --> "*" MovimientoPuntos
  Pedido "1" *-- "*" HistorialPedido
  Cupon "*" --> "0..1" Perfil : cupón personal
```

---

## 3. Diagrama de secuencia — Compra y pago con Mercado Pago

```mermaid
sequenceDiagram
  autonumber
  actor C as Cliente
  participant W as checkout.html / checkout.js
  participant B as data.js (window.Befine)
  participant DB as Supabase (crear_pedido / RLS)
  participant EF as Edge Function mp-webhook
  participant MP as Mercado Pago
  participant OF as OpenFactura

  C->>W: Completa datos, comuna y documento
  W->>W: Valida RUT, celular y correo (forms.js)
  W->>B: crearPedido(items, dirección, cupón)
  B->>DB: rpc("crear_pedido", …)
  DB->>DB: Recalcula precios, despacho y cupón desde la BD
  DB-->>B: Pedido #N en pendiente_pago
  B->>EF: Crear preferencia de pago
  EF->>MP: POST /checkout/preferences (access token secreto)
  MP-->>EF: init_point
  EF-->>W: URL de pago
  W->>MP: Redirige al cliente
  C->>MP: Paga
  MP-)EF: Notificación (webhook)
  EF->>MP: GET /v1/payments/{id} (no confía en el cuerpo)
  alt Pago aprobado y monto coincide
    EF->>DB: rpc("confirmar_pago") con service_role
    DB->>DB: pagado → en_preparacion, descuenta stock, suma puntos (idempotente)
    EF->>OF: Emitir boleta/factura
    OF-->>EF: Folio + PDF
    EF->>DB: Guarda documento_tributario (emitido)
  else Rechazado o monto distinto
    EF->>DB: Registra pago rechazado (el pedido no avanza)
  end
  MP-->>C: Vuelve a la tienda (página de confirmación)
```

---

## 4. Diagrama de secuencia — Reparto y aviso por WhatsApp

```mermaid
sequenceDiagram
  autonumber
  actor CH as Chofer
  participant P as Panel (vista chofer)
  participant DB as Supabase (marcar_reparto)
  participant WA as WhatsApp
  actor CL as Cliente

  CH->>P: Abre "Mis entregas"
  P->>DB: select pedidos (RLS: permiso pedidos.ver)
  DB-->>P: Pedidos en_preparacion / en_ruta
  CH->>P: Pulsa "En camino"
  P->>DB: rpc("marcar_reparto", pedido, "en_ruta")
  DB->>DB: Valida transición y registra historial (chofer, hora)
  DB-->>P: teléfono + mensaje
  P->>WA: Abre wa.me/569… con el mensaje
  WA-->>CL: "Tu pedido va en camino"
  CH->>P: Pulsa "Entregado"
  P->>DB: rpc("marcar_reparto", pedido, "entregado")
  DB-->>P: teléfono + mensaje con los datos de la entrega
  P->>WA: wa.me/…
  WA-->>CL: "Tu pedido fue entregado" (cierra el ciclo)
```

---

## 5. Diagrama de estados — Pedido

```mermaid
stateDiagram-v2
  [*] --> pendiente_pago : crear_pedido()
  pendiente_pago --> pagado : webhook MP aprobado
  pendiente_pago --> cancelado : pago rechazado / expira
  pagado --> en_preparacion : automático al validar el pago
  en_preparacion --> en_ruta : chofer "En camino"
  en_ruta --> entregado : chofer "Entregado"
  en_preparacion --> cancelado : admin (con reembolso)
  entregado --> [*]
  cancelado --> [*]
```

Cada transición queda en `historial_pedido` (RNF-09). Las transiciones del chofer están limitadas por `marcar_reparto()`: solo `en_preparacion → en_ruta → entregado`.

---

## 6. Diagrama de componentes

Componentes de la solución y sus dependencias (detalle de capas y seguridad en [Arquitectura.md](Arquitectura.md)).

```mermaid
flowchart TB
  subgraph Cliente["Navegador (móvil / escritorio)"]
    direction TB
    UI["Páginas HTML<br/>index · catalogo · producto · checkout · cuenta · admin*"]
    JS["Capa JS<br/>shell.js · ui.js · fx.js · forms.js · store.js"]
    API["Puente de datos<br/>data.js → window.Befine"]
    LS[("localStorage<br/>carrito · datos recordados")]
    UI --> JS --> API
    JS --> LS
  end

  subgraph Supabase["Supabase (BaaS)"]
    AUTH["Auth<br/>correo/contraseña · Google OAuth"]
    REST["PostgREST<br/>API REST automática"]
    DB[("PostgreSQL<br/>21 tablas + roles/permisos<br/>RLS en todas las tablas")]
    RPC["Funciones SQL<br/>crear_pedido() · tiene_permiso()<br/>marcar_reparto()* · confirmar_pago()*"]
    EF["Edge Functions (Deno)<br/>resenas-google · mp-webhook* · emitir-dte*"]
    REST --> DB
    RPC --> DB
    EF --> RPC
  end

  subgraph Externos["Servicios externos"]
    MP["Mercado Pago"]
    OF["OpenFactura / SII"]
    GP["Google Places API"]
    WA["WhatsApp (wa.me)"]
  end

  API -- "supabase-js (HTTPS + anon key)" --> AUTH
  API --> REST
  API --> RPC
  API -- "functions.invoke" --> EF
  EF --> GP
  EF -- "preferencia de pago" --> MP
  MP -- "webhook" --> EF
  EF --> OF
  JS -. "abre enlace con mensaje" .-> WA

  classDef pend stroke-dasharray: 5 5
  class EF,RPC pend
```
<sub>\* Componentes en construcción (Sprints 3–4) o escritos y pendientes de aplicar.</sub>
