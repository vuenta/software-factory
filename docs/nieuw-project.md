# Nieuw project op de factory aansluiten

## Eenmalig op je eigen computer

```bash
claude plugin marketplace add vuenta/software-factory
claude plugin install factory@vuenta-factory
```

Daarna zijn `/factory:refine`, `/factory:implement` en `/factory:review` beschikbaar in Claude Code (ook in VS Code). Projecten met de template-instellingen vragen dit ook zelf aan bij het openen.

## Per project

1. **Bestanden plaatsen.** Vanuit een kopie van deze repo:
   ```bash
   scripts/install-into.sh <pad/naar/project>
   ```
   Start je vanuit een projecttemplate (zoals het basisplatform) waar deze bestanden al in zitten, dan sla je dit over.
2. **`CLAUDE.md` invullen**: projectnaam, stack, structuur en projectregels. Kort houden; agents lezen het bij elke run.
3. **Specificatie** in `docs/SPECIFICATIE.md` zetten.
4. **Claude GitHub-app** installeren op de repo: github.com/apps/claude.
5. **Secret toevoegen.** Draai lokaal `claude setup-token` en zet het resultaat in de repo onder *Settings → Secrets and variables → Actions* als `CLAUDE_CODE_OAUTH_TOKEN`. De runs gaan dan van je abonnement af.
6. **Labels** aanmaken: `scripts/labels.sh <eigenaar/repo>` (vereist GitHub CLI).
7. **Bord** inrichten volgens `docs/werkwijze.md`.
8. **Branch protection** op `main`: PR verplicht, CI moet slagen, geen force-push.

## Testen of alles werkt
1. Maak een klein issue en zet het op *Ready*.
2. Schrijf in het issue: `@claude /factory:implement <nummer>`.
3. Controleer: er komt een branch, CI draait op de PR, en de review verschijnt als comment.

## Let op
- De review- en Claude-workflow halen de factory-plugin op uit `vuenta/software-factory`. Is die repo privé, dan moet de Claude GitHub-app ook toegang tot deze repo hebben. Lukt het ophalen niet, maak de factory-repo dan openbaar (er staan geen geheimen in).
- Elke run telt mee in je gebruikslimiet. Houd issues klein; `--max-turns` in de workflows begrenst een vastgelopen run.
