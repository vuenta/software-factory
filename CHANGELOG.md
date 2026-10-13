# Changelog

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
