# <Projectnaam>

<Eén of twee zinnen: wat dit project is en voor wie.> De functionele specificatie staat in `docs/SPECIFICATIE.md`.

## Stack
<Bijvoorbeeld: TypeScript, pnpm workspaces, Fastify, Zod, Prisma, PostgreSQL, Vue 3, PrimeVue (unstyled) + Tailwind, Vitest, Playwright.>

## Commando's
| Doel | Commando |
|---|---|
| Installeren | `pnpm install` |
| Lokaal starten | `pnpm dev` |
| Lint | `pnpm lint` |
| Typecheck | `pnpm typecheck` |
| Tests | `pnpm test` |
| Build | `pnpm build` |

## Structuur
<Korte boom van de belangrijkste mappen en wat erin hoort. Markeer platformcode (`platform`-mappen) die alleen met label `area:platform` gewijzigd mag worden.>

## Conventies
- TypeScript strict; geen `any` zonder toelichting.
- Commits volgens Conventional Commits met issuenummer: `feat(api): ... (#12)`.
- Branches: `feat/<nr>-<omschrijving>`, `fix/...`, `chore/...`.
- Geen geheimen in de repo; configuratie via omgevingsvariabelen.
- <Projectspecifieke regels, bijv. "Elke query op tenantdata via de tenant-context", "Alleen design tokens, geen vaste kleuren of pixels".>

## Werkwijze
Dit project gebruikt de factory-plugin:
- `/factory:refine <idee>` — idee of epic → issues met acceptatiecriteria
- `/factory:implement <issuenummer>` — issue → branch, tests, code, PR
- `/factory:review <PR-nummer>` — onafhankelijke review

Werk altijd vanuit een issue. Eén issue per sessie. Merge nooit zelf.

## Definition of Done
Een issue is af als:
1. Alle acceptatiecriteria zijn gebouwd en elk is aangetoond met een geautomatiseerde test.
2. Lint, typecheck, tests en build slagen lokaal én in CI.
3. Geen wijzigingen buiten de scope van het issue.
4. Nieuwe tenantdata: isolatietest aanwezig.
5. Nieuwe of gewijzigde API: schema's bijgewerkt, OpenAPI-document opnieuw gegenereerd.
6. UI: laad-, leeg- en fouttoestand uitgewerkt; alleen design tokens; getest op mobiel en desktop.
7. De PR verwijst naar het issue (`Closes #<nr>`) en de review-agent heeft geen blokkerende bevindingen.
8. De PO heeft de PR goedgekeurd en gemerged.
