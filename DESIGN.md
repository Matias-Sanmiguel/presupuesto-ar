# DESIGN.md — Presupuesto AR

## Product
Agent skill that turns a list of named components into an Argentine consumer-price quote (`.tex` + PDF): Mercado Libre first, other AR storefronts as needed, exact-match only.

## Audience
Delivery-ready quote PDF — clean enough to share; research notes stay in `fuentes.md`.

## Visual system (`latex/tecnicocobre.sty`)

| Token | Value | Role |
| --- | --- | --- |
| Cobre | `#B86A3D` / deep `#8C4A2A` | Accent rules, totals, links |
| Slate | `#2C3A47` | Titles, strong text |
| Ink | `#1B2228` | Body |
| Muted | `#6B7580` | Meta, footer |
| Sand | `#F7F1EB` | Table header / total band |
| Rule | `#D7C4B5` | Soft separators |

No “Técnico · Cobre” branding in the running header. Header: **Presupuesto** + date. Footer: IVA note + page.

## Hierarchy
1. Thick copper rule → title → muted meta
2. Table (sand header, alternating sand-tint rows)
3. Sand total band
4. Referencias: **exactly 3 product URLs per item** (delivery requirement); mirror in `fuentes.md`

## Anti-slop
- No purple, no cream+serif cliché stack, no emoji/badges
- Delivery PDF: no agent process notes (“revalidado 3 veces”, etc.)
