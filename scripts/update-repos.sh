#!/usr/bin/env bash
# Rigenera la tabella dei repository dell'organizzazione tra i marker
# <!-- REPOS:START --> ... <!-- REPOS:END --> in profile/README.md.
#
# Richiede: gh CLI + jq. Env: GH_TOKEN (PAT read-only org), ORG (default ItalianGres).
set -euo pipefail

ORG="${ORG:-ItalianGres}"
README="${README:-profile/README.md}"

command -v gh >/dev/null || { echo "gh non trovato" >&2; exit 1; }
command -v jq >/dev/null || { echo "jq non trovato" >&2; exit 1; }

# Repo non archiviati, ordinati per nome. type=all => include privati (col PAT).
rows="$(gh api --paginate \
  "orgs/${ORG}/repos?per_page=100&type=all&sort=full_name&direction=asc" \
  --jq '.[] | select(.archived == false)
        | [ .name, .html_url, (.description // "—"), .private, (.language // "—") ]
        | @tsv')"

block_file="$(mktemp)"
{
  echo '| Repo | Descrizione | Visibilità | Linguaggio |'
  echo '|---|---|---|---|'
  while IFS=$'\t' read -r name url desc private lang; do
    [ -z "${name}" ] && continue
    if [ "${private}" = "true" ]; then vis="🔒 Privato"; else vis="🌐 Pubblico"; fi
    # Neutralizza eventuali pipe nella descrizione per non rompere la tabella.
    desc="${desc//|/\\|}"
    printf '| [**%s**](%s) | %s | %s | %s |\n' "${name}" "${url}" "${desc}" "${vis}" "${lang}"
  done <<< "${rows}"
} > "${block_file}"

# Sostituisce il contenuto tra i marker (marker inclusi mantenuti).
awk -v cf="${block_file}" '
  /<!-- REPOS:START -->/ { print; while ((getline l < cf) > 0) print l; skip=1; next }
  /<!-- REPOS:END -->/   { skip=0 }
  !skip { print }
' "${README}" > "${README}.tmp"

mv "${README}.tmp" "${README}"
rm -f "${block_file}"
echo "Tabella repository aggiornata."
