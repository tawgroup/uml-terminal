#!/usr/bin/env bash
set -euo pipefail
for dest in "$HOME/.claude/skills" "$HOME/.agents/skills" "$HOME/.cursor/skills" "$HOME/.gemini/config/skills"; do
  target="$dest/uml-terminal"
  if [ -L "$target" ]; then rm "$target"; echo "go  $target"; fi
done
echo "Xong."
