# presupuesto-ar

Agent skill for **Cursor**, **Codex**, and **Claude Code**: Argentine consumer-price quotes as delivery-ready LaTeX/PDF.

Exact component names. **Three product URLs per line item.** Copper print style.

Repo: [github.com/Matias-Sanmiguel/presupuesto-ar](https://github.com/Matias-Sanmiguel/presupuesto-ar)

---

## Install

```bash
git clone https://github.com/Matias-Sanmiguel/presupuesto-ar.git
cd presupuesto-ar
chmod +x scripts/install.sh
./scripts/install.sh                  # Cursor + Codex + Claude, this project
./scripts/install.sh --claude --user  # Claude Code only, global
./scripts/install.sh --cursor --user  # Cursor only, global
./scripts/install.sh --codex --user   # Codex only, global
./scripts/install.sh --force          # replace existing install
```

| Target | Project | User |
| --- | --- | --- |
| Cursor | `.cursor/skills/presupuesto-ar` | `~/.cursor/skills/presupuesto-ar` |
| Codex | `.codex/skills/presupuesto-ar` | `~/.codex/skills/presupuesto-ar` |
| Claude Code | `.claude/skills/presupuesto-ar` | `~/.claude/skills/presupuesto-ar` |

Canonical source: `skills/presupuesto-ar/`. The installer symlinks (or copies) it into the harness folders.

In Claude Code you can also run `/presupuesto-ar` once installed.

---

## Use

Ask the agent:

> Armá un presupuesto AR para: ESP32 ×3, protoboard 830, kit Dupont

It will search Argentine listings (Mercado Libre first), put **exactly 3 URLs** per item in the PDF, re-check the quoted price, and write `.tex` + `.pdf` under `presupuestos/`.

Rules: [`skills/presupuesto-ar/SKILL.md`](skills/presupuesto-ar/SKILL.md)

---

## Layout

```
skills/presupuesto-ar/   # SKILL.md + template.tex
latex/                   # tecnicocobre.sty + fonts
presupuestos/            # generated quotes
scripts/install.sh       # Cursor / Codex / Claude installer
DESIGN.md                # visual system
```

Compile with XeLaTeX, LuaLaTeX, or Tectonic (`latex/ejemplo/presupuesto.tex`).

---

## Design

Print-first copper identity — [`DESIGN.md`](DESIGN.md).

Accent `#B86A3D`, slate titles, sand table bands. Delivery PDF: no agent process notes; references carry three links per item.

---

## License

MIT (`LICENSE`). Fonts: `latex/fonts/*LICENCIA*`.
