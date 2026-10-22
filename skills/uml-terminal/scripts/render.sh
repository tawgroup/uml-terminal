#!/usr/bin/env bash
# Render PlantUML sequence diagrams to unicode text, strip trailing spaces, report real width.
# Usage: render.sh a.puml [b.puml ...]  -> writes a.utxt next to each input and prints it.
set -euo pipefail
command -v plantuml >/dev/null || { echo "plantuml not found - run: brew install plantuml" >&2; exit 1; }
[ $# -gt 0 ] || { echo "usage: render.sh <file.puml> [...]" >&2; exit 2; }
plantuml -tutxt "$@"
for f in "$@"; do
  out="${f%.puml}.utxt"
  [ -f "$out" ] || { echo "no output for $f (syntax error above?)" >&2; continue; }
  python3 - "$out" <<'PY'
import sys
p = sys.argv[1]
lines = [l.rstrip() for l in open(p, encoding="utf-8").read().splitlines()]
open(p, "w", encoding="utf-8").write("\n".join(lines) + "\n")
print(f"{p}  lines={len(lines)}  width={max(len(l) for l in lines)}  (target <= 100)")
PY
  cat "$out"; echo
done
