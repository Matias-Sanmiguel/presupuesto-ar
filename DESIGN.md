# DESIGN.md — Presupuesto AR (Técnico Cobre)

## Product
Agent skill that turns a list of named components into an Argentine consumer-price quote (`.tex` + PDF): Mercado Libre first, other AR storefronts as needed, exact-match only.

## Audience
Whoever needs a clean, checkable local quote — builders, students, freelancers — reading ARS final prices with sources.

## Visual system
Derived from `tecnicocobre.sty` (copper accent `#A65F38`, Nimbus Sans, JetBrains Mono). Tuned with Impeccable principles for print docs:

| Token | Value | Role |
| --- | --- | --- |
| Accent | `#A65F38` | Rules, section titles, totals, bullets |
| Ink | `#1A1A1A` | Body |
| Muted | `#5C5C5C` | Meta, footnotes, headers |
| Rule | `#C9B2A3` | Soft separators / table rules |
| Paper | white | No cream fill, no purple, no glow |

## Hierarchy (one job per band)
1. Copper label + thick rule → document type
2. Title + muted meta (date, scope)
3. Soft rule → item table (qty / component / unit / subtotal / source id)
4. Thick rule → total
5. Fuentes: id, store, URL, consult timestamp

## Anti-slop (Impeccable)
- No decorative cards, badges, or emoji
- No second accent color
- No dense newspaper columns
- Empty states: explicit `No encontrado:` lines, never silent omission
- Distill: table + fuentes + total; nothing else unless the user asked

## Motion / interaction
Print-first. Digital PDF may keep copper hyperlinks on source URLs.
