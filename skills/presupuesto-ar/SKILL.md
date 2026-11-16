---
name: presupuesto-ar
description: >-
  Arma presupuestos en LaTeX/PDF con precios de consumidor final en Argentina
  (IVA incluido), con exactamente 3 URLs de producto por ítem en el PDF de
  entrega. Busca el componente exacto en Mercado Libre y otras tiendas AR. Use
  when the user asks for un presupuesto, cotización local, precios AR, LaTeX
  presupuesto, or lists components to price in Argentina.
---

# Presupuesto AR (LaTeX · cobre)

## When to use
User wants a local Argentine quote for named components (Cursor, Codex, Claude Code, or any agent that loads this skill) → produce delivery-ready `.tex` + PDF styled with `latex/tecnicocobre.sty`.

## Non-negotiables
1. **Solo páginas argentinas** (`.com.ar` o tiendas con precio en ARS para comprador local).
2. **Componente exacto** — el nombre que dio el usuario, sin “similares” silenciosos.
3. **Exactamente 3 URLs por ítem en el PDF** — obligatorio de entrega. Tres fichas/publicaciones distintas del mismo producto (idealmente 3 tiendas). **No inventar links.** Si no se llegan a 3 URLs reales → no cotizar ese ítem: `\NoEncontrado{...}` y explicar en el reply (y en `fuentes.md`).
4. **Verificar el precio 2 o 3 veces** en la ficha elegida para cotizar antes de fijarlo.
5. **Precio a consumidor final, IVA incluido**.
6. **Si no hay match exacto →** `\NoEncontrado{...}`; no sustituir salvo OK explícito del usuario.
7. **Mercado Libre preferido**; si no, cualquier tienda AR.
8. **Sin scripts de scraping en el repo** — el agente busca (browser / headless / fetch).
9. Visual: [DESIGN.md](../../DESIGN.md) + `latex/tecnicocobre.sty`. PDF **para entregar**: sin notas de proceso (“revalidado”, “OK del usuario”, etc.).

## Workflow

```
Presupuesto:
- [ ] 1. Lista de componentes (verbatim)
- [ ] 2. Carpeta de salida
- [ ] 3. Por ítem: 3 URLs reales + precio (2–3 checks) o No encontrado
- [ ] 4. .tex con \FuenteTres (3 urls) por cada ítem cotizado
- [ ] 5. Compilar PDF
- [ ] 6. Resumir totales + faltantes
```

### 1. Parse input
Keep each component string **exactly** as named. Default qty = 1 if missing.

### 2. Output folder
```
presupuestos/YYYY-MM-DD-<slug-corto>/
  presupuesto.tex
  presupuesto.pdf
  fuentes.md
```
Ensure `fonts/` resolves (`latex/fonts` via symlink or `\input@path`).

### 3. Price each component
Order: Mercado Libre → other AR shops.

For each item:
1. Collect **exactly 3** distinct product URLs (same model/SKU). Keep searching until you have 3 or conclude it is impossible.
2. Confirm titles match; discard wrong variants.
3. Quote the best of the three (in-stock + lowest stable consumer price).
4. Re-check that price **2–3 times**; note volatility only in `fuentes.md`.
5. Write all three URLs into the PDF via `\FuenteTres` **and** into `fuentes.md`.

Impossible to get 3 real URLs → `\NoEncontrado{nombre}` (do not ship 1–2 links for that item).

Prefer **new** listings. Chrome headless / browser OK. No login bypass; if price is not public, skip that listing.

### 4. Write LaTeX
Base on [template.tex](template.tex) and `latex/tecnicocobre.sty`.

Required bands:
1. `\SetPresupuestoFecha{…}`
2. `\PresupuestoEncabezado{titulo}{meta}`
3. `\NotaIva`
4. Table: `# | Componente | Unitario | Subtotal | Ref.`
5. `\NoEncontrado{...}` if any
6. `\TotalPresupuesto{$…}` — only found items
7. `\section*{Referencias}` with **`\FuenteTres{Fxx}{Tienda — nota}{url1}{url2}{url3}` for every quoted row**

Money format: `\$12.450` / `\$12.450,50`.

### 5. Compile
```bash
xelatex -interaction=nonstopmode presupuesto.tex
# or: tectonic presupuesto.tex
```

### 6. Reply
- Total ARS (IVA incluido)
- Found vs not found
- Path to PDF
- Not a formal invoice / PO

## Anti-patterns
- PDF Referencias with fewer (or more) than **3 URLs per ítem cotizado**
- Inventing placeholder/fake URLs to pad to three
- USD / foreign storefronts as the quoted price
- Silent “similar” substitutions
- Single-pass price without re-check
- Omitting missing items
- Agent process notes in the delivery PDF
- Redesigning away from cobre / Nimbus
