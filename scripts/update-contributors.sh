#!/usr/bin/env bash
# Aggrega i contributor di TUTTI i repo dell'organizzazione e rigenera la
# griglia di avatar tra i marker
# <!-- CONTRIBUTORS:START --> ... <!-- CONTRIBUTORS:END --> in profile/README.md.
#
# Richiede: gh CLI + jq. Env: GH_TOKEN (PAT read-only org), ORG (default ItalianGres).
set -euo pipefail

ORG="${ORG:-ItalianGres}"
README="${README:-profile/README.md}"

command -v gh >/dev/null || { echo "gh non trovato" >&2; exit 1; }
command -v jq >/dev/null || { echo "jq non trovato" >&2; exit 1; }

repos="$(gh api --paginate \
  "orgs/${ORG}/repos?per_page=100&type=all" \
  --jq '.[] | select(.archived == false) | .full_name')"

raw="$(mktemp)"
for repo in ${repos}; do
  # Esclude i bot (type != User). 204/empty su repo senza commit => ignora.
  gh api --paginate "repos/${repo}/contributors?per_page=100" \
    --jq '.[] | select(.type == "User")
          | [ .login, (.contributions|tostring), .avatar_url, .html_url ]
          | @tsv' 2>/dev/null || true
done >> "${raw}"

# Somma i commit per login su tutti i repo, ordina desc.
agg="$(awk -F'\t' '
  { c[$1]+=$2; a[$1]=$3; u[$1]=$4 }
  END { for (k in c) printf "%d\t%s\t%s\t%s\n", c[k], k, a[k], u[k] }
' "${raw}" | sort -rn)"
rm -f "${raw}"

block_file="$(mktemp)"
if [ -z "${agg}" ]; then
  echo '<sub>Nessun contributor rilevato.</sub>' > "${block_file}"
else
  {
    echo '<p align="left">'
    while IFS=$'\t' read -r count login avatar url; do
      [ -z "${login}" ] && continue
      printf '  <a href="%s" title="%s · %s commit"><img src="%s&s=64" width="56" height="56" alt="%s" style="border-radius:50%%" /></a>\n' \
        "${url}" "${login}" "${count}" "${avatar}" "${login}"
    done <<< "${agg}"
    echo '</p>'
  } > "${block_file}"
fi

awk -v cf="${block_file}" '
  /<!-- CONTRIBUTORS:START -->/ { print; while ((getline l < cf) > 0) print l; skip=1; next }
  /<!-- CONTRIBUTORS:END -->/   { skip=0 }
  !skip { print }
' "${README}" > "${README}.tmp"

mv "${README}.tmp" "${README}"
rm -f "${block_file}"
echo "Griglia contributor aggiornata."
