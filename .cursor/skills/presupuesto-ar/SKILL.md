---
name: presupuesto-ar
description: >-
  Arma presupuestos en LaTeX/PDF con precios de consumidor final en Argentina
  (IVA incluido), buscando el componente exacto en Mercado Libre y otras tiendas
  AR. Use when the user asks for un presupuesto, cotización local, precios AR,
  LaTeX presupuesto, or lists components to price in Argentina.
---

# Presupuesto AR (LaTeX · Técnico Cobre)

## When to use
User wants a local Argentine quote for named components → produce `.tex` + PDF in the project, styled with `latex/tecnicocobre.sty`.

## Non-negotiables
1. **Solo páginas argentinas** (`.com.ar` o tiendas con precio en ARS para comprador local).
2. **Componente exacto** — el nombre que dio el usuario, sin “similares” silenciosos.
3. **Verificar el precio 2 o 3 veces** en la misma ficha (reabrir / refrescar / re-leer) antes de fijarlo.
4. **Precio a consumidor final, IVA incluido** (el que ve el comprador en la publicación).
5. **Si no hay match exacto → decirlo** con `\NoEncontrado{...}`; no inventar ni sustituir.
6. **Mercado Libre preferido**; si no hay, cualquier tienda AR que lo tenga.
7. **Sin scripts de scraping en el repo** — el agente busca (browser / Chrome headless / fetch) siguiendo estas instrucciones.
8. Visual: seguir [DESIGN.md](../../../DESIGN.md) y el estilo cobre; no rediseñar ad hoc.

## Workflow

Copy and track:

```
Presupuesto:
- [ ] 1. Lista de componentes (verbatim)
- [ ] 2. Carpeta de salida
- [ ] 3. Precio por ítem (2–3 checks) o No encontrado
- [ ] 4. Escribir .tex desde la plantilla
- [ ] 5. Compilar PDF
- [ ] 6. Resumir totales + faltantes al usuario
```

### 1. Parse input
Keep each component string **exactly** as named. Ask only if qty is missing (default qty = 1).

### 2. Output folder
```
presupuestos/YYYY-MM-DD-<slug-corto>/
  presupuesto.tex
  presupuesto.pdf
  fuentes.md          # opcional: log de consultas
```
Copy or symlink fonts: ensure `fonts/` is reachable as in the example (`latex/fonts` via `\input@path` or compile from `latex/`).

### 3. Price each component
Order of stores:
1. Mercado Libre Argentina
2. Other AR retailers that list the exact product (CompraGamer, HardGamers, Frávega, Musimundo, sitios de marca `.com.ar`, etc.)

For each item:
- Search the **exact** string / model.
- Open the product page; confirm title matches the requested component (same model/SKU sense).
- Read the **consumer final** price (ARS, taxes included as shown).
- Re-check **2–3 times** (reload or re-read the price node). If it changes, take the latest stable reading and note volatility in `fuentes.md`.
- Record: unit price, URL, store, timestamp (ISO local), qty, subtotal.

If no exact listing after a serious search → `\NoEncontrado{nombre exacto}` and continue.

Prefer **new** listings when both new and used appear; if only used exists, mark it in the fuente note and still require exact model match.

Chrome headless / browser tools are allowed when search APIs are insufficient. Prefer ML. Do not bypass paywalls or logins; skip and mark unavailable if the price is not public.

### 4. Write LaTeX
Base on [template.tex](template.tex) and `latex/tecnicocobre.sty`.

Required bands:
1. `\PresupuestoEncabezado{titulo}{meta}`
2. `\NotaIva`
3. Table: `# | Componente | Unitario | Subtotal | Ref.`
4. All `\NoEncontrado{...}` lines
5. `\TotalPresupuesto{$…}` — sum only found items
6. `Fuentes` with F01… and `\url{...}`

Format money as Argentine: `\$12.450` or `\$12.450,50`.

No issuer letterhead (CUIT/logo) unless the user adds it later.

### 5. Compile
From a directory where `tecnicocobre.sty` and `fonts/` resolve:

```bash
xelatex -interaction=nonstopmode presupuesto.tex
# or: tectonic presupuesto.tex
```

Ship both `.tex` and `.pdf` in the output folder.

### 6. Reply to user
- Total ARS (IVA incluido)
- Count found vs not found (list missing names)
- Path to PDF
- Do not claim the PDF is a formal invoice or binding quote

## Anti-patterns
- Using USD or foreign storefronts as the quoted price
- Substituting a “similar” component without an explicit user OK
- Single-pass price scrape without re-check
- Omitting missing items
- Redesigning away from cobre / Nimbus / copper rules
