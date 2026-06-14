#!/usr/bin/env bash
# test-id-collision-delta.sh — closed-loop проверка check-id-collision-delta.sh.
# see WP-388 Ф14. Запуск: bash SPF/scripts/test-id-collision-delta.sh
set -uo pipefail

GUARD="$(cd "$(dirname "$0")" && pwd)/check-id-collision-delta.sh"
T="$(mktemp -d "${TMPDIR:-/tmp}/iwe-idguard-XXXXXX")"
trap 'rm -rf "$T"' EXIT

cd "$T"
git init -q
git config user.email t@t && git config user.name t
mkdir -p pack/dom/08-service-clauses pack/dom/02-domain-entities
echo "id: DP.SC.178"  > pack/dom/08-service-clauses/DP.SC.178-voice.md
echo "id: DP.SC.180"  > pack/dom/08-service-clauses/DP.SC.180-unit.md
echo "id: DP.ROLE.178" > pack/dom/02-domain-entities/DP.ROLE.178-role.md
git add -A && git commit -qm init

fails=0
check() { # name expected_exit
  bash "$GUARD" >/tmp/idg.$$ 2>&1; local rc=$?
  if [ "$rc" -eq "$2" ]; then echo "  PASS [$1] exit=$rc"; else
    echo "  FAIL [$1] exit=$rc, ожидал $2"; sed 's/^/      /' /tmp/idg.$$; fails=$((fails+1)); fi
  rm -f /tmp/idg.$$
}

echo "T1 дубль DP.SC.178 (added) → блок"
echo "id: DP.SC.178" > pack/dom/08-service-clauses/DP.SC.178-second.md
git add pack/dom/08-service-clauses/DP.SC.178-second.md; check "dup-blocks" 1
git reset -q; rm pack/dom/08-service-clauses/DP.SC.178-second.md

echo "T2 уникальный DP.SC.181 (added) → проход"
echo "id: DP.SC.181" > pack/dom/08-service-clauses/DP.SC.181-new.md
git add pack/dom/08-service-clauses/DP.SC.181-new.md; check "unique-passes" 0
git reset -q; rm pack/dom/08-service-clauses/DP.SC.181-new.md

echo "T3 DP.ROLE.180 — тот же номер, другой тип → проход"
echo "id: DP.ROLE.180" > pack/dom/02-domain-entities/DP.ROLE.180-x.md
git add pack/dom/02-domain-entities/DP.ROLE.180-x.md; check "diff-type-passes" 0
git reset -q; rm pack/dom/02-domain-entities/DP.ROLE.180-x.md

echo "T4 правка существующего (modified, не added) → проход"
echo "# edit" >> pack/dom/08-service-clauses/DP.SC.178-voice.md
git add pack/dom/08-service-clauses/DP.SC.178-voice.md; check "edit-passes" 0
git reset -q; git checkout -q -- pack/dom/08-service-clauses/DP.SC.178-voice.md

echo "T5 граница: DP.SC.1800 при наличии DP.SC.180 → проход (не путать)"
echo "id: DP.SC.1800" > pack/dom/08-service-clauses/DP.SC.1800-big.md
git add pack/dom/08-service-clauses/DP.SC.1800-big.md; check "boundary-passes" 0
git reset -q; rm pack/dom/08-service-clauses/DP.SC.1800-big.md

echo "T6 next-free подсказка корректна (max=180/178 → next 181)"
echo "id: DP.SC.178" > pack/dom/08-service-clauses/DP.SC.178-third.md
git add pack/dom/08-service-clauses/DP.SC.178-third.md
T6OUT="$(bash "$GUARD" 2>&1)"
echo "$T6OUT" | grep -q "следующий свободный: DP.SC.181" && echo "  PASS [next-free=181]" || { echo "  FAIL [next-free] — фактический вывод:"; echo "$T6OUT" | sed 's/^/      /'; fails=$((fails+1)); }
git reset -q

echo ""
[ "$fails" -eq 0 ] && echo "ВСЕ ТЕСТЫ ПРОШЛИ" || echo "ПРОВАЛОВ: $fails"
exit "$fails"
