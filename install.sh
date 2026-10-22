#!/usr/bin/env bash
# Cài skill uml-terminal bằng symlink — sửa trong repo là 4 harness thấy ngay.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills/uml-terminal"
[ -d "$SRC" ] || { echo "khong thay $SRC"; exit 1; }

for dest in "$HOME/.claude/skills" "$HOME/.agents/skills" "$HOME/.cursor/skills" "$HOME/.gemini/config/skills"; do
  mkdir -p "$dest"
  target="$dest/uml-terminal"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "backup ban cu: $target -> $target.bak"
    rm -rf "$target.bak"
    mv "$target" "$target.bak"
  fi
  ln -sfn "$SRC" "$target"
  echo "OK  $target -> $SRC"
done

echo
echo "Xong. Thoat han Claude Code / Codex / Cursor / Antigravity (agy) roi mo lai — skill chi nap luc khoi dong."
