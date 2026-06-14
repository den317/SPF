#!/usr/bin/env bash
# test-precommit-integration.sh — end-to-end: реальный git commit с симлинком
# на pre-commit-pack-map. Проверяет, что коллизия РЕАЛЬНО блокирует коммит.
# see WP-388 Ф14.
set -uo pipefail

WRAPPER="$(cd "$(dirname "$0")" && pwd)/pre-commit-pack-map"
T="$(mktemp -d "${TMPDIR:-/tmp}/iwe-precommit-XXXXXX")"
trap 'rm -rf "$T"' EXIT

cd "$T"
git init -q
git config user.email t@t && git config user.name t
ln -sf "$WRAPPER" .git/hooks/pre-commit
mkdir -p pack/dom/08-service-clauses
printf 'kind: pack\n' > pack/dom/00-pack-manifest.md
echo "id: DP.SC.500" > pack/dom/08-service-clauses/DP.SC.500-a.md
git add -A && git commit -qm init >/dev/null 2>&1

fails=0

echo "INT1: коммит НОВОГО DP.SC.500 (дубль) → ожидаю отказ git commit"
echo "id: DP.SC.500" > pack/dom/08-service-clauses/DP.SC.500-b.md
git add pack/dom/08-service-clauses/DP.SC.500-b.md
if git commit -qm "dup" >/tmp/int.$$ 2>&1; then
  echo "  FAIL — коммит прошёл, а должен был блокироваться"; fails=$((fails+1))
else
  echo "  PASS — коммит заблокирован"; grep -q "ID-коллизия" /tmp/int.$$ && echo "  PASS — сообщение гарда показано"
fi
git reset -q; rm -f pack/dom/08-service-clauses/DP.SC.500-b.md /tmp/int.$$

echo "INT2: коммит уникального DP.SC.501 → ожидаю успех"
echo "id: DP.SC.501" > pack/dom/08-service-clauses/DP.SC.501-c.md
git add pack/dom/08-service-clauses/DP.SC.501-c.md
if git commit -qm "unique" >/tmp/int.$$ 2>&1; then
  echo "  PASS — уникальный ID прошёл"
else
  echo "  FAIL — уникальный заблокирован зря:"; sed 's/^/      /' /tmp/int.$$; fails=$((fails+1))
fi
rm -f /tmp/int.$$

echo ""
[ "$fails" -eq 0 ] && echo "ИНТЕГРАЦИЯ: ВСЕ ПРОШЛИ" || echo "ИНТЕГРАЦИЯ ПРОВАЛОВ: $fails"
exit "$fails"
