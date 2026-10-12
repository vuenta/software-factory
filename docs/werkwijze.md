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
                          In progress ──▶ PR "Closes #nr"
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

## Bord (GitHub Projects)

Kolommen (veld *Status*): **Backlog → Ready → In progress → Review → Done → Live**.

| Kolom | Betekenis | Hoe kom je erin |
|---|---|---|
| Backlog | Idee of uitgewerkt issue, nog niet goedgekeurd | Automatisch bij nieuw issue |
| Ready | Goedgekeurd; een agent mag beginnen | **Alleen jij** verplaatst hierheen |
| In progress | Agent werkt eraan | Bij start van implement |
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
