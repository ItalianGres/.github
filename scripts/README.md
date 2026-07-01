# Script di aggiornamento profilo

Rigenerano le sezioni **Repository** e **Contributor** di [`../profile/README.md`](../profile/README.md)
tra i marker `<!-- REPOS:* -->` e `<!-- CONTRIBUTORS:* -->`.

Eseguiti in automatico da [`../.github/workflows/update-profile.yml`](../.github/workflows/update-profile.yml)
(cron giornaliero + avvio manuale da tab *Actions*).

## Setup del secret `ORG_READONLY_TOKEN` (una tantum)

Le Action devono leggere i repo **privati** dell'org: il `GITHUB_TOKEN` di default non basta.
Serve un **fine-grained PAT** read-only.

1. GitHub → **Settings → Developer settings → Personal access tokens → Fine-grained tokens → Generate new token**.
2. **Resource owner:** organizzazione `ItalianGres`.
3. **Repository access:** *All repositories*.
4. **Permissions → Repository:**
   - `Metadata` → **Read-only** (obbligatorio)
   - `Contents` → **Read-only**
5. Genera il token e copialo.
6. Nel repo `ItalianGres/.github`: **Settings → Secrets and variables → Actions → New repository secret**
   - Nome: `ORG_READONLY_TOKEN`
   - Valore: il token.

Scadenza consigliata: 90 giorni; rinnovare aggiornando il secret.

## Esecuzione locale (test)

```bash
export GH_TOKEN=<pat>          # oppure: gh auth login
export ORG=ItalianGres
bash scripts/update-repos.sh
bash scripts/update-contributors.sh
git diff -- profile/README.md
```

> Nota: gli script elencano solo i repo dell'org `ItalianGres`. Il repo e-commerce, se
> resta su un account personale, non comparirà finché non viene trasferito nell'org.
