---
name: review
description: Laat een pull request of branch onafhankelijk beoordelen door de reviewer-agent, getoetst aan het issue en de Definition of Done. Gebruik bij "review PR", "beoordeel deze branch".
argument-hint: "[PR-nummer] [--comment] [--geen-controles]"
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash(git *) Bash(gh pr view *) Bash(gh pr diff *) Bash(gh issue view *) Bash(gh pr comment *) Bash(gh pr review *)
---

# Review

Input: $ARGUMENTS

1. Bepaal wat er beoordeeld wordt:
   - Een PR-nummer: gebruik `gh pr view <nr>` en `gh pr diff <nr>`.
   - Geen nummer: de huidige branch ten opzichte van `main` (`git diff main...HEAD`).
2. Zoek het gekoppelde issue (`Closes #<nr>` in de PR-tekst) en lees de acceptatiecriteria.
3. Geef de beoordeling aan de subagent **reviewer** van deze plugin. Geef hem alleen: het PR- of branchnummer, het issuenummer en de opdracht. Niet je eigen mening over de code; de reviewer moet met een schone blik kijken. Staat `--geen-controles` in de input (zoals in CI, waar een aparte workflow de controles draait), zeg de reviewer dan dat hij lint, typecheck en tests niet zelf draait.
4. Toon het oordeel van de reviewer ongewijzigd.
5. Staat `--comment` in de input, plaats het oordeel dan op de PR:
   - `gh pr comment <nr> --body "<oordeel>"`
   - Wijzig zelf **niets** aan de code.
