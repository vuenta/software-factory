---
name: review
description: Laat een pull request of branch onafhankelijk beoordelen door de reviewer-agent, getoetst aan het issue en de Definition of Done. Gebruik bij "review PR", "beoordeel deze branch".
argument-hint: "[PR-nummer] [--comment] [--geen-controles]"
disable-model-invocation: true
allowed-tools: Read Grep Glob Agent Bash(git *) Bash(gh pr view *) Bash(gh pr diff *) Bash(gh issue view *) Bash(gh pr comment *)
---

# Review

Input: $ARGUMENTS

1. Bepaal wat er beoordeeld wordt:
   - Een PR-nummer: gebruik `gh pr view <nr>` en `gh pr diff <nr>`.
   - Geen nummer: de huidige branch ten opzichte van `main` (`git diff main...HEAD`).
2. Zoek het gekoppelde issue (`Closes #<nr>` in de PR-tekst) en lees de acceptatiecriteria.
3. Laat de beoordeling doen met een schone blik:
   - **Kan je een subagent starten**, geef de opdracht dan aan de subagent **reviewer** van deze plugin. Geef hem alleen het PR- of branchnummer, het issuenummer en de opdracht; niet je eigen mening over de code.
   - **Kan dat niet** (bijvoorbeeld in GitHub Actions, waar deze sessie zelf al een schone context heeft), voer de review dan **zelf** uit volgens de instructies in `${CLAUDE_PLUGIN_ROOT}/agents/reviewer.md`. Lees dat bestand eerst en volg het volledig.
   - Staat `--geen-controles` in de input (zoals in CI, waar een aparte workflow lint, typecheck en tests draait), dan worden die controles niet opnieuw gedraaid.
4. Toon het oordeel ongewijzigd, in het formaat uit `reviewer.md`.
5. Staat `--comment` in de input, dan is **het plaatsen van het oordeel verplicht**; stop niet voordat dat gelukt is:
   - Plaats het in één commando met een heredoc, zodat opmaak en aanhalingstekens intact blijven:
     ```bash
     gh pr comment <nr> --body-file - <<'OORDEEL'
     <oordeel>
     OORDEEL
     ```
   - Mislukt dat, meld dan de foutmelding letterlijk.
   - Wijzig zelf **niets** aan de code.
