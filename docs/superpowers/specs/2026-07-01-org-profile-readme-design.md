# Design — README profilo organizzazione ItalianGres

**Data:** 2026-07-01
**Repo:** `ItalianGres/.github`
**Deliverable:** `profile/README.md` (pagina profilo dell'organizzazione GitHub)

---

## Obiettivo

README per l'organizzazione GitHub **ItalianGres**, rivolto a personale tecnico. Tre scopi combinati:

1. **Onboarding dev interni** — partire in fretta sul progetto.
2. **Vetrina tecnica** — mostrare qualità ingegneristica a candidati/dev esterni.
3. **Indice repo** — mappa dei repository dell'organizzazione.

Lingua: **italiano** (team interno).

---

## Decisioni chiave

- **Posizionamento file.** GitHub renderizza la pagina profilo org solo da `profile/README.md` dentro il repo `.github`. Il `README.md` di root viene ridotto a una nota che rimanda a `profile/README.md`.
- **Approccio B (ibrido vetrina + onboarding), statico.** Niente auto-generazione via API/PAT: l'org ha pochi repo, quasi tutti privati → un visitatore anonimo non li vedrebbe comunque e la gestione del token non vale la complessità.
- **Unico elemento dinamico:** contributor list tramite immagine `contrib.rocks` (nessun token, si aggiorna da sola).
- **Auto-listing repo:** non implementato ora. Documentato come "come abilitarlo in futuro" se l'org cresce.

---

## Contesto tecnico di riferimento (dal repo ecommerce `../italiangres`)

- E-commerce **PrestaShop 9**, tema `italiangres` basato su Hummingbird.
- Moduli custom con prefisso `ig_*` (`ig_helpers`, `ig_pdp_custom_logic`, `ig_bypasscart`, `ig_banners`, …).
- DB: **ObjectModel** (legacy/front) + **Doctrine ORM** (back moderno) + migrazioni **Flyway**.
- Infra: **Docker Compose** con interfaccia **`make`**.
- Qualità: **PHPStan**, **php-cs-fixer**, **Rector**, module validator custom.
- CI (`.github/workflows/`): deploy DEV incrementale con marker SHA (`src:<sha>`), **Lighthouse** orario (mobile+desktop, Chrome pinnato) su `development.italiangres.com`.
- Tooling AI (`.claude/`): skill PS9 per dominio, subagent (`security-auditor`, `query-auditor`, `ig-helper-finder`, `ps9-reviewer`, …), workflow multi-agente (`security-audit-sweep`, `raw-sql-orm-audit`), hook guard (`guard-paths.sh`, `guard-git.sh`).
- Regole d'oro: codice in **inglese**, prefisso `ig_`, ORM-first, hooks-over-overrides, `index.php` in ogni dir, **mai commit autonomi**.

> Nota: il repo ecommerce è oggi su `robbycassa/italiangres` (privato). Nell'indice repo va indicato come privato; se verrà trasferito nell'org, aggiornare il link.

---

## Struttura `profile/README.md`

1. **Header** — nome/tagline ItalianGres (e-commerce gres/ceramica su PrestaShop 9) + riga badge stack (PHP, PrestaShop 9, Symfony, Docker, MySQL/MariaDB, Flyway). Badge shields.io statici.
2. **Chi siamo (tecnicamente)** — 3-4 righe: cosa costruiamo + filosofia (ORM-first, hooks-over-overrides, codice in inglese, AI-assisted).
3. **Stack & architettura** — tabella compatta: front (Hummingbird, SCSS/Twig/Smarty), moduli `ig_*`, DB (ObjectModel + Doctrine + Flyway), infra (Docker + `make`).
4. **Ingegneria & qualità** — vetrina: CI deploy incrementale, Lighthouse orario/CWV, PHPStan, php-cs-fixer, Rector, module validator custom.
5. **AI-assisted development** — differenziatore: skill PS9, subagent, workflow multi-agente, hook guard. Sintesi di `.claude/`.
6. **Onboarding rapido** — quick start: clone → `make docker-up` → URL locali → leggere `CLAUDE.md` → regole d'oro.
7. **Repository** — indice statico: ecommerce (privato), `.github`, eventuali altri. Descrizione + link + stato visibilità.
8. **Contributor** — immagine `contrib.rocks`.
9. **Footer** — sito/contatti, nota licenza.

---

## Modifiche ai file

- **Nuovo:** `profile/README.md` — contenuto sopra.
- **Modifica:** `README.md` (root) — nota breve: "Repo profilo org ItalianGres. Il contenuto della pagina profilo è in `profile/README.md`."
- **Nuovo:** questo spec in `docs/superpowers/specs/`.

## Fuori scope

- Auto-generazione indice repo via GitHub Actions/PAT (solo documentata per il futuro).
- Traduzione EN / bilingue.
- Asset grafici custom (logo SVG dedicato) — si usano badge shields.io.

## Criteri di completamento

- `profile/README.md` renderizza correttamente come pagina profilo org.
- Nessun link rotto; badge visibili.
- Copre i 3 obiettivi (onboarding, vetrina, indice) in italiano.
- Contributor list `contrib.rocks` presente.
