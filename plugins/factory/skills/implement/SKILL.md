---
name: implement
description: Bouw één GitHub-issue van begin tot PR - branch, tests, code, controle en pull request. Gebruik bij "implementeer issue", "bouw #12".
argument-hint: "[issuenummer]"
disable-model-invocation: true
allowed-tools: Read Edit Write Glob Grep Bash(git *) Bash(gh issue view *) Bash(gh issue comment *) Bash(gh pr create *) Bash(gh pr view *) Bash(pnpm *) Bash(npx *)
---

# Implementeer issue #$0

Je bent de developer. Je bouwt precies wat issue #$0 vraagt, niet meer.

## 1. Begrijp
- Lees het issue: `gh issue view $0 --comments`.
- Lees `CLAUDE.md`. Lees alleen de code die je voor dit issue nodig hebt.
- Ontbreken acceptatiecriteria, of spreken ze de specificatie tegen? Plaats een comment op het issue met je vraag en **stop**.

## 2. Plan
- Maak een branch vanaf de actuele `main`: `git switch -c <type>/$0-<korte-omschrijving>` (type = feat, fix of chore).
- Noem in maximaal 8 punten welke bestanden je wijzigt en welke tests je schrijft.
- Raakt het plan code in een `platform`-map terwijl het issue geen label `area:platform` heeft? Stop en vraag het eerst.

## 3. Bouw
- Schrijf eerst tests die de acceptatiecriteria uitdrukken; die falen eerst.
- Implementeer tot ze slagen.
- Commit in kleine stappen met Conventional Commits, bijvoorbeeld `feat(api): tenant aanmaken (#$0)`.
- Houd je aan de conventies in `CLAUDE.md`. Geen nieuwe dependencies zonder dat het issue erom vraagt; noem ze anders in de PR.

## 4. Controleer
Voer de controles uit die `CLAUDE.md` noemt (minimaal lint, typecheck, tests, build). Alles moet slagen. Loop de **Definition of Done** in `CLAUDE.md` na.

## 5. Lever op
- `git push -u origin HEAD`
- Maak de PR met `gh pr create`:
  - Titel: zelfde stijl als de commits.
  - Body volgens `.github/pull_request_template.md`, met `Closes #$0`, per acceptatiecriterium waar het getest wordt, en aannames of open punten.
- Plaats een korte comment op het issue met de link naar de PR.
- Kun je zelf geen PR aanmaken (zoals in GitHub Actions)? Push de branch en zet in je antwoord de link om de PR aan te maken, met de PR-tekst erbij.

## Als je vastloopt
Na twee mislukte pogingen op hetzelfde probleem: commit wat werkt, plaats een comment op het issue met wat je geprobeerd hebt en waar het vastzit, en stop. Ga niet gokken.

## Grenzen
- Merge nooit zelf. De PO merget.
- Wijzig nooit `.github/workflows/`, secrets of deploy-configuratie, tenzij het issue daar expliciet over gaat.
- Zet nooit geheimen of echte wachtwoorden in code, tests of commits.
