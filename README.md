# Software Factory

De werkwijze, agents en GitHub-inrichting waarmee projecten van Vuenta gebouwd worden: van idee via backlog, bouw, test en review tot live. Herbruikbaar voor elk project.

## Wat zit erin

| Map | Inhoud |
|---|---|
| `plugins/factory/` | Claude Code-plugin: skills `refine`, `implement`, `review` en de agent `reviewer` |
| `.claude-plugin/marketplace.json` | Maakt deze repo installeerbaar als pluginbron |
| `template/` | Bestanden voor elk project: `CLAUDE.md`-sjabloon met Definition of Done, issue- en PR-templates, workflows (CI, @claude, review), Dependabot, Claude-instellingen |
| `scripts/` | `install-into.sh` (template in een project zetten), `labels.sh` (standaardlabels) |
| `docs/` | `werkwijze.md` (rollen, flow, bord), `nieuw-project.md` (stappenplan) |

## In het kort

1. **Refine:** `/factory:refine <idee>` maakt issues met toetsbare acceptatiecriteria. Jij keurt goed en zet ze op *Ready*.
2. **Implement:** `/factory:implement <nr>` (lokaal of via `@claude` in het issue) bouwt het issue met tests en opent een PR.
3. **Controle:** CI draait lint, typecheck, tests en build; de reviewer-agent beoordeelt de PR met een schone context en plaatst zijn oordeel.
4. **Merge en deploy:** blijven bij jou.

## Installeren

In Claude Code:

```
/plugin install factory --marketplace vuenta/software-factory
```

Of in de terminal: `claude plugin marketplace add vuenta/software-factory` en daarna `claude plugin install factory@vuenta-factory`.

Start daarna bij [`docs/nieuw-project.md`](docs/nieuw-project.md).

## De factory zelf verbeteren

- Wijzig skills en agents in `plugins/factory/`, verhoog `version` in `plugin.json` en noteer de wijziging in `CHANGELOG.md`.
- Controleer met `claude plugin validate .` en `claude plugin validate ./plugins/factory`.
- Projecten krijgen een nieuwe pluginversie via `claude plugin update factory@vuenta-factory`; bestanden uit `template/` neem je per project over.
