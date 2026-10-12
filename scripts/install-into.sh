#!/usr/bin/env bash
# Kopieert de factory-bestanden (template/) naar een projectmap.
# Bestaande bestanden worden NIET overschreven; die worden gemeld.
# Gebruik: scripts/install-into.sh <pad/naar/project>
set -euo pipefail

TARGET="${1:?Gebruik: scripts/install-into.sh <pad/naar/project>}"
SRC="$(cd "$(dirname "$0")/../template" && pwd)"

[ -d "$TARGET" ] || { echo "Map bestaat niet: $TARGET" >&2; exit 1; }

cd "$SRC"
find . -type f | while read -r f; do
  dest="$TARGET/${f#./}"
  if [ -e "$dest" ]; then
    echo "overgeslagen (bestaat al): ${f#./}"
  else
    mkdir -p "$(dirname "$dest")"
    cp "$f" "$dest"
    echo "toegevoegd: ${f#./}"
  fi
done

echo
echo "Klaar. Volgende stappen staan in docs/nieuw-project.md van de factory."
