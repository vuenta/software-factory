# Werkwijze

Van idee tot live, met jou als product owner (PO) en agents als developer en reviewer.

## Rollen

| Rol | Wie | Doet |
|---|---|---|
| Product owner | Jij | Bepaalt wat en waarom, zet issues op *Ready*, merget PR's, keurt deploys goed |
| Refinement | Claude + jij | `/factory:refine`: idee → issues met acceptatiecriteria |
| Developer | Claude | `/factory:implement`: issue → branch, tests, code, PR |
| Reviewer | Aparte agent, schone context, wijzigt niets | `/factory:review`: toetst de PR aan het issue en de Definition of Done |
| Kwaliteitspoort | CI (GitHub Actions) | Lint, typecheck, tests, build. Geen LLM. |
| Release | Jij keurt goed, CI/CD deployt | Per project ingericht |

Rollen bestaan alleen waar ze iets toevoegen: een schone context voor de review, andere rechten (de reviewer schrijft niet), of een kleinere taak. Agents praten niet met elkaar; de overdracht loopt via het issue en de PR.

## De flow

```
Idee ──/factory:refine──▶ Issue (Backlog)
                              │  jij: akkoord
                              ▼
                          Ready
                              │  /factory:implement <nr>   (lokaal of "@claude /factory:implement <nr>" in het issue)
                              ▼
                          In progress ──▶ PR "Closes #nr"   (via @claude opent auto-pr.yml de PR zelf)
                                              │
                              ┌───────────────┼────────────────┐
                              ▼               ▼                ▼
                          CI-controles   Claude review    jij bekijkt
                              └───────────────┼────────────────┘
                                              ▼  jij merget
                                            Done
                                              │  deploy (na goedkeuring)
                                              ▼
                                            Live
```

## Dagelijkse routine voor de PO

Je doet maar twee dingen: een issue starten en mergen. De rest gaat vanzelf.

1. **Starten:** zet op het issue het comment `@claude /factory:implement <nr>`. Zet `@claude` niet in de beschrijving van een nieuw issue, want dan start hij meteen.
2. **Wachten** (10 tot 60 minuten). Na afloop opent `auto-pr.yml` de PR met `Closes #<nr>` en de labels van het issue, en starten CI en de review.
3. **Beoordelen** op de PR:

| CI-vinkje | Review | Wat jij doet |
|---|---|---|
| ✅ groen | GOEDGEKEURD | **Merge** |
| ✅ groen | WIJZIGINGEN NODIG | Comment `@claude verwerk de review` |
| ❌ rood | (wat dan ook) | **Niet mergen.** Comment `@claude CI faalt, los het op` |
| ❌ rood, alleen screenshots | | **Actions → Update screenshot baselines → Run workflow** op de branch van de PR (zie hieronder) |
| "This branch has conflicts" | | Lokaal Claude Code: *"werk PR #<nr> bij met main en los de conflicten op"* |

**Vaste regel:** nooit mergen met een rood CI-kruis, ook niet als de review GOEDGEKEURD zegt.

### Goed om te weten
- **Review:** alleen een *blokkerende* bevinding geeft WIJZIGINGEN NODIG. *Belangrijk* en *Klein* blokkeren niet; jij beslist of je ze oppakt. Het review-comment komt van `github-actions[bot]` en wordt bij elke push bijgewerkt.
- **Wat `@claude` op GitHub niet kan:** bestanden in `.github/workflows/` wijzigen (beveiliging van GitHub) en merge-conflicten oplossen (bewuste keuze van `claude-code-action`). Daarvoor is lokaal Claude Code nodig.
- **Screenshot-baselines** (projecten met Playwright): de workflow *Update screenshot baselines* maakt alle screenshots opnieuw in CI, commit ze naar de PR-branch en start CI daarna zelf. Controleer de afbeeldingen bij *Files changed*.
- **Runs met "action required" of "Waiting for approval"** na zo'n automatische commit zijn dubbelingen; het groene CI-vinkje is de echte uitslag.
- **Parallel:** start alleen issues tegelijk die niet van elkaar afhangen (zie *Afhankelijkheden* in het issue). Merge je er één, dan kan de ander conflicten krijgen.
- **Een issue dat van een ander afhangt,** pas starten als dat andere issue gemerged is; anders bouwt de agent op een oude versie van main.

### Hoe de automatisering in elkaar zit
| Workflow | Start bij | Doet |
|---|---|---|
| `claude.yml` | `@claude` in een issue of PR | Claude Code werkt aan het issue en pusht een branch; start daarna `auto-pr.yml` |
| `auto-pr.yml` | na `claude.yml`, of een push naar `claude/issue-*` | Opent de PR (als die er nog niet is), neemt de labels over, start CI en review |
| `ci.yml` | PR, push naar `main`, of handmatig | Lint, typecheck, tests, build (en Playwright waar ingericht) |
| `claude-review.yml` | PR, of gestart door `auto-pr.yml` | Onafhankelijke review; oordeel als comment |

Een push of PR die met het standaard `GITHUB_TOKEN` gemaakt is, start op GitHub geen andere workflows. Daarom starten `auto-pr.yml` en de baseline-workflow CI en review zelf via `workflow_dispatch`.

## Bord (GitHub Projects)

Kolommen (veld *Status*): **Backlog → Ready → In progress → Review → Done → Live**.

| Kolom | Betekenis | Hoe kom je erin |
|---|---|---|
| Backlog | Idee of uitgewerkt issue, nog niet goedgekeurd | Automatisch bij nieuw issue |
| Ready | Goedgekeurd; een agent mag beginnen | **Alleen jij** verplaatst hierheen |
| In progress | Agent werkt eraan | Jij, bij het starten van `/factory:implement` (nog niet geautomatiseerd) |
| Review | PR staat open | Automatisch bij PR met `Closes #nr` (zie inrichting) |
| Done | Gemerged | Automatisch bij sluiten van het issue |
| Live | Gedeployed | Jij, of de deploy-workflow |

*Ready* is je controleknop: alleen wat daar staat wordt gebouwd.

### Bord inrichten (eenmalig per project)
1. GitHub → je organisatie of account → **Projects → New project → Board**.
2. Hernoem de kolommen van het veld *Status* naar de zes hierboven.
3. Voeg velden toe: *Prioriteit* (P1, P2, P3) en *Epic* (tekst).
4. Menu **⋯ → Workflows** en zet aan:
   - *Auto-add to project*: filter `is:issue,pr is:open` op de projectrepo
   - *Item added to project* → Status **Backlog**
   - *Pull request linked to issue* → Status **Review** (als beschikbaar)
   - *Item closed* en *Pull request merged* → Status **Done**
5. Maak extra weergaven: *Tabel* (alles met velden) en *Roadmap* (per epic).

## Afspraken

- **Eén issue per sessie.** Daarna een nieuwe sessie. Dat houdt de context schoon en het verbruik laag.
- **Klein houden.** Past een issue niet in één sessie (`size:L`), dan eerst opknippen.
- **Voortgang staat in GitHub, niet in het gesprek.** Loopt een sessie vast of op de gebruikslimiet, dan kan een nieuwe sessie verder vanuit het issue, de comments en de commits.
- **Parallel werken** pas als het fundament staat, en alleen op issues die elkaar niet raken (elk op een eigen branch).
- **Productie:** agents krijgen nooit productiesleutels. Merge en deploy blijven bij jou.
