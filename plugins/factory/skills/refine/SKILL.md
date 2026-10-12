---
name: refine
description: Werk een idee of epic uit tot een of meer GitHub-issues met user story en toetsbare acceptatiecriteria. Gebruik bij "refine", "maak een issue van", "knip deze epic op".
argument-hint: "[idee, epic of issuenummer]"
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash(gh issue view *) Bash(gh issue list *) Bash(gh label list *)
---

# Refinement

Je werkt een idee uit tot issues die een developer-agent zelfstandig kan bouwen. Je schrijft **geen code**.

Input: $ARGUMENTS
(Is dit een issuenummer, lees het dan eerst met `gh issue view`.)

## Werkwijze

1. Lees `CLAUDE.md` en, als die bestaat, `docs/SPECIFICATIE.md`. Een issue mag de specificatie niet tegenspreken; zie je een conflict, meld het en stop.
2. Bepaal de omvang. Eén issue = werk dat in **één sessie** past (ruwweg: één endpoint, één scherm, één migratie). Is het groter, knip het op in meerdere issues en geef de volgorde en afhankelijkheden aan.
3. Schrijf per issue de tekst hieronder.
4. Stel maximaal 3 vragen als iets echt onduidelijk is. Kies anders een conservatieve aanname en zet die onder **Aannames**.
5. Toon de issues aan de gebruiker. Maak ze **pas aan na akkoord**, met `gh issue create --title ... --body ... --label ...`. De gebruiker (PO) zet ze daarna zelf op *Ready*.

## Issuetekst

```markdown
## Doel
Als <rol> wil ik <functie>, zodat <waarde>.

## Acceptatiecriteria
- [ ] Gegeven <situatie>, wanneer <actie>, dan <verwacht resultaat>
- [ ] ...
(Elk criterium is toetsbaar met een geautomatiseerde test. Noem statuscodes, foutcodes en randgevallen expliciet.)

## Technische aanwijzingen
- Betrokken onderdelen / bestanden (zo specifiek mogelijk)
- Verwijzing naar het relevante hoofdstuk van de specificatie

## Buiten scope
- Wat dit issue bewust niet doet

## Aannames
- ...

## Afhankelijkheden
- Na #<nr> (of: geen)
```

## Labels

Kies één `type:` (feature, bug, chore, docs) en één of meer `area:` (api, web, platform, infra, design). Grootte als `size:S`, `size:M` of `size:L`; `size:L` betekent: verder opknippen.
