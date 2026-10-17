# Changelog

## Documentatie — 2026-10-17
- `docs/werkwijze.md`: dagelijkse routine voor de PO (beslistabel per PR-situatie), beperkingen van `@claude`, screenshot-baselines en een overzicht van de workflows.

## 0.1.6 — 2026-10-17
- Template `claude.yml`: start na afloop `auto-pr.yml` voor de branch van `@claude`. Een push van `@claude` zelf start geen workflow, waardoor de PR voor #35 niet automatisch werd geopend.
- Template `auto-pr.yml`: ook via `workflow_dispatch` met een branch te starten; negeert andere branches.

## 0.1.5 — 2026-10-17
- Template `claude-review.yml`: `github_token: ${{ github.token }}`. Het token van de Claude-app mocht de CI-runs niet lezen (HTTP 403 op `gh run list`); het workflow-token heeft `actions: read` wel. De review-comment komt nu van `github-actions[bot]`.

## 0.1.4 — 2026-10-17
- Template `auto-pr.yml` (nieuw): na een push van `@claude` naar `claude/issue-<nr>-…` opent een workflow de PR met `Closes #<nr>` en de labels van het issue, en start CI en de review. Geen "Create PR"-link meer klikken.
- Template `ci.yml` en `claude-review.yml`: ook te starten via `workflow_dispatch` (door `auto-pr.yml`); de review accepteert `github-actions[bot]` als starter.
- Template `claude.yml`: volledige git-historie en Bash voor `pnpm`, `git` en lezende `gh`-commando's, zodat `@claude` de tests zelf kan draaien.
- `reviewer` en `review`: CI-status via `gh run list` (REST) in plaats van `gh pr checks`, dat in Actions met het standaardtoken faalt.

## 0.1.3 — 2026-10-17
- `reviewer`: duidelijke zwaarte per bevinding. Alleen een **blokkerende** bevinding leidt tot WIJZIGINGEN NODIG; belangrijke en kleine bevindingen staan erbij, maar de PR wordt GOEDGEKEURD. Wat de reviewer niet kan controleren is geen bevinding.
- `reviewer` en `review`: CI-status via `gh pr checks` onder *Controles*; nog lopende of onleesbare CI is geen bevinding.
- Template `claude-review.yml`: rechten `actions`, `checks` en `statuses` (lezen) en `gh pr checks` toegestaan, zodat de reviewer de CI-uitslag kan zien.

## 0.1.2 — 2026-10-13
- `review`: één review-comment per PR die bij elke push wordt bijgewerkt (`--edit-last`), met de beoordeelde commit erin.
- Template: brede deny op `.env*` behouden (ook `.env.example`); `CLAUDE.md` legt vast dat de PO `.env.example` bijwerkt en agents nieuwe variabelen in de PR noemen.

## 0.1.1 — 2026-10-13
- `review`: werkt nu ook in GitHub Actions. Kan er geen subagent gestart worden, dan voert de sessie de review zelf uit volgens `reviewer.md`; het plaatsen van de comment is verplicht en gebeurt via een heredoc.
- Template `claude-review.yml`: Dependabot-PR's overgeslagen, `Agent`/`Task` toegestaan, `show_full_output` aan voor onderzoek.
- `install-into.sh`: relatieve doelmap (zoals `.`) werkt nu correct.

## 0.1.0 — 2026-10-12
- Plugin `factory` met skills `refine`, `implement`, `review` en agent `reviewer`.
- Template: `CLAUDE.md` met Definition of Done, issue- en PR-templates, workflows voor CI, `@claude` en automatische review, Dependabot, Claude-instellingen.
- Scripts: `install-into.sh`, `labels.sh`.
- Documentatie: werkwijze, bord en stappenplan voor een nieuw project.
