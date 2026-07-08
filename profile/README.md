<div align="center">

# ItalianGres

**E-commerce di gres porcellanato e ceramica — costruito su PrestaShop 9.**

![PHP](https://img.shields.io/badge/PHP-8.1+-777BB4?logo=php&logoColor=white)
![PrestaShop](https://img.shields.io/badge/PrestaShop-9-DF0067?logo=prestashop&logoColor=white)
![Symfony](https://img.shields.io/badge/Symfony-black?logo=symfony&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL%20%2F%20MariaDB-4479A1?logo=mysql&logoColor=white)
![Flyway](https://img.shields.io/badge/Flyway-CC0200?logo=flyway&logoColor=white)

</div>

---

## Chi siamo (tecnicamente)

Sviluppiamo e gestiamo un e-commerce **PrestaShop 9** per la vendita di gres porcellanato e ceramica, con logiche di prodotto su misura (prezzi al m², combinazioni, formati, finiture, campioni).

Filosofia di ingegneria:

- **ORM-first** — ObjectModel e Doctrine prima dell'SQL grezzo.
- **Hooks over overrides** — estendere il core senza modificarlo.
- **Codice in inglese** — le traduzioni passano dal sistema PS9, mai hardcoded.
- **AI-assisted** — skill, subagent e workflow versionati nel repo guidano lo sviluppo.

---

## Stack & architettura

| Livello | Tecnologie |
|---|---|
| **Front-end** | Tema `italiangres` (base Hummingbird) · Twig · Smarty · SCSS |
| **Moduli custom** | Prefisso `ig_*` — `ig_helpers` (utility condivise), `ig_pdp_custom_logic`, `ig_bypasscart`, `ig_banners`, … |
| **Back-end** | PrestaShop 9 · Symfony · pattern CQRS per i moduli moderni |
| **Database** | ObjectModel (legacy/front) · Doctrine ORM (back) · migrazioni **Flyway** (`V{n}__{desc}.sql`) |
| **Infra** | Docker Compose · interfaccia unica via **`make`** |

---

## Ingegneria & qualità

Ogni modifica passa da controlli automatici:

- **CI deploy incrementale** — build & deploy dell'ambiente DEV innescati sul push, con marker `src:<sha>` per non ricostruire ciò che è già stato costruito (nessun deploy silenziosamente saltato su push multi-commit).
- **Lighthouse orario** — Core Web Vitals (mobile + desktop) su `development.italiangres.com`, con versione di Chrome pinnata per confronti settimana-su-settimana stabili.
- **Analisi statica** — PHPStan (con baseline e regole disallowed-calls).
- **Stile & modernizzazione** — php-cs-fixer + Rector.
- **Module validator custom** — sostituto automatico di `validator.prestashop.com` per i moduli `ig_*`.

---

## Sviluppo AI-assisted

Il progetto versiona un set di strumenti per specializzare gli agenti AI (Claude Code, Gemini CLI, Antigravity) sul dominio PrestaShop 9:

- **Skill di dominio** — core, moduli, tema, DB, API, checkout, sicurezza, email, performance, Lighthouse, traduzioni. Caricate on-demand in base al task.
- **Subagent** — `ig-helper-finder` (riuso helper esistenti), `security-auditor`, `query-auditor`, `ps9-reviewer`, `override-to-hook-advisor`, `ig-module-scaffolder`.
- **Workflow multi-agente** — `security-audit-sweep`, `raw-sql-orm-audit` per audit esaustivi con verifica adversariale.
- **Hook guard** — bloccano modifiche agli asset compilati e commit/branch fuori standard.

---

## Contributor

<!-- CONTRIBUTORS:START -->
<p align="left">
  <a href="https://github.com/DevManfre" title="DevManfre · 1413 commit"><img src="https://avatars.githubusercontent.com/u/94976747?v=4&s=64" width="56" height="56" alt="DevManfre" style="border-radius:50%" /></a>
  <a href="https://github.com/robbycassa" title="robbycassa · 501 commit"><img src="https://avatars.githubusercontent.com/u/12562139?v=4&s=64" width="56" height="56" alt="robbycassa" style="border-radius:50%" /></a>
  <a href="https://github.com/gabrielerighi93" title="gabrielerighi93 · 274 commit"><img src="https://avatars.githubusercontent.com/u/244496801?v=4&s=64" width="56" height="56" alt="gabrielerighi93" style="border-radius:50%" /></a>
</p>
<!-- CONTRIBUTORS:END -->

> Aggregati da tutti i repo dell'org e aggiornati da [`update-profile.yml`](../.github/workflows/update-profile.yml).

---

<div align="center">
<sub>ItalianGres · <a href="https://italiangres.com">italiangres.com</a> · Codice proprietario</sub>
</div>
