# Changelog

## Ongepubliceerd
- Template `.claude/settings.json`: deny-regels noemen de echte `.env`-bestanden expliciet, zodat `.env.example` niet meer geblokkeerd wordt.

## 0.1.1 — 2026-10-13
- `review`: werkt nu ook in GitHub Actions. Kan er geen subagent gestart worden, dan voert de sessie de review zelf uit volgens `reviewer.md`; het plaatsen van de comment is verplicht en gebeurt via een heredoc.
- Template `claude-review.yml`: Dependabot-PR's overgeslagen, `Agent`/`Task` toegestaan, `show_full_output` aan voor onderzoek.
- `install-into.sh`: relatieve doelmap (zoals `.`) werkt nu correct.

## 0.1.0 — 2026-10-12
- Plugin `factory` met skills `refine`, `implement`, `review` en agent `reviewer`.
- Template: `CLAUDE.md` met Definition of Done, issue- en PR-templates, workflows voor CI, `@claude` en automatische review, Dependabot, Claude-instellingen.
- Scripts: `install-into.sh`, `labels.sh`.
- Documentatie: werkwijze, bord en stappenplan voor een nieuw project.
