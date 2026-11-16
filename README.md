# presupuesto-ar

Skill de Cursor para armar **presupuestos en LaTeX/PDF** con precios de **consumidor final en Argentina** (IVA incluido), estilo **Técnico Cobre**.

## Qué hace
- Toma una lista de componentes **por nombre exacto**
- Busca en páginas AR (Mercado Libre preferido; otras tiendas si hace falta)
- Revalida cada precio **2–3 veces**
- Genera `.tex` + `.pdf` en `presupuestos/`
- Si no hay match exacto, lo declara (`No encontrado`)

## Uso en Cursor
La skill vive en `.cursor/skills/presupuesto-ar/`. Pedí por ejemplo:

> Armá un presupuesto AR para: Ryzen 5 5600, B550M, 16GB DDR4 3200

El agente sigue `SKILL.md`, usa `latex/tecnicocobre.sty` y la plantilla del skill.

## Estilo
- `latex/tecnicocobre.sty` — identidad cobre (`#A65F38`), Nimbus Sans, JetBrains Mono
- `DESIGN.md` — sistema visual (Impeccable)
- Fuentes tipográficas en `latex/fonts/` (ver licencias ahí)

## Compilar el ejemplo
Requiere XeLaTeX, LuaLaTeX o Tectonic:

```bash
cd latex/ejemplo
# asegurar que ../tecnicocobre.sty y ../fonts resuelvan; o:
xelatex -interaction=nonstopmode <<'EOF'
\documentclass{article}
\makeatletter\def\input@path{{../}}\makeatother
\usepackage{tecnicocobre}
\begin{document}ok\end{document}
EOF
```

Más simple: desde `latex/ejemplo` con path fix en el `.tex` (ver skill template), o:

```bash
cd latex && xelatex -output-directory=ejemplo ejemplo/presupuesto.tex
```

(ajustá `\usepackage` / `\input@path` según cómo compiles).

## Impeccable
Skills Impeccable en `.cursor/skills/impeccable/` (el binario del engine no se versiona). Tras clonar:

```bash
npx impeccable install -y --project --providers=cursor
```

`DESIGN.md` fija el sistema visual del presupuesto (jerarquía cobre, anti-slop).

## Licencia
Código y skill: MIT (ver `LICENSE`). Tipografías: ver `latex/fonts/*LICENCIA*`.
