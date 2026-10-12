# Software Factory (deze repo)

Deze repo bevat de factory: een Claude Code-plugin (`plugins/factory/`), een marketplace-manifest, projecttemplates (`template/`) en documentatie. Er zit geen applicatiecode in.

## Regels
- Houd het klein. Voeg alleen een skill, agent of workflow toe als die aantoonbaar iets oplost dat nu misgaat.
- Taal van documentatie en skills: Nederlands.
- Na elke wijziging aan de plugin: `claude plugin validate .` en `claude plugin validate ./plugins/factory` moeten slagen.
- Workflows in `template/.github/workflows/` controleren met actionlint.
- Bij een wijziging aan de plugin: `version` in `plugins/factory/.claude-plugin/plugin.json` verhogen en `CHANGELOG.md` bijwerken.
- `template/` bevat generieke bestanden; projectspecifieke zaken (zoals een deploy-workflow) horen in het project of het basisplatform.
