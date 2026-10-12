#!/usr/bin/env bash
# Maakt de standaardlabels van de factory aan in een repo.
# Gebruik: scripts/labels.sh <eigenaar/repo>
# Vereist: GitHub CLI (gh), ingelogd met schrijfrechten op de repo.
set -euo pipefail

REPO="${1:?Gebruik: scripts/labels.sh <eigenaar/repo>}"

label() {
  gh label create "$1" --repo "$REPO" --color "$2" --description "$3" --force
}

# Type
label "type:feature" "1d76db" "Nieuwe functionaliteit"
label "type:bug"     "d73a4a" "Iets werkt niet zoals bedoeld"
label "type:chore"   "cfd3d7" "Onderhoud, configuratie, afhankelijkheden"
label "type:docs"    "0075ca" "Documentatie"

# Gebied
label "area:api"      "5319e7" "Backend / API"
label "area:web"      "0e8a16" "Frontend"
label "area:platform" "b60205" "Platformcode; alleen wijzigen met dit label"
label "area:infra"    "fbca04" "CI/CD, server, deploy"
label "area:design"   "f9d0c4" "Design system en vormgeving"

# Grootte
label "size:S" "c2e0c6" "Klein: minder dan een uur agentwerk"
label "size:M" "fef2c0" "Middel: past in één sessie"
label "size:L" "f9c0c0" "Te groot: opknippen met /factory:refine"

# Overig
label "needs-info" "d876e3" "Wacht op antwoord van de PO"

echo "Labels aangemaakt in $REPO"
