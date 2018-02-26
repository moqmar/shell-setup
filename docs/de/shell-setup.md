---
description: Detaillierte Erklärung der von shell-setup vorgenommenen Konfigurationsänderungen
prev: /de/
prevTitle: Was ist shell-setup?
next: /de/bootstrap.html
nextTitle: Das Bootstrap-Skript
---
# Das shell-setup Repository

```bash
$ make
Usage: make install[-zsh|-vim|-micro|-tmux]|clean|get-fontawesome|ssh-keygen|chsh 
```

# zsh-Konfiguration
- Antigen mit folgenden Plugins:
  - extract
  - command-not-found
  - colored-man-pages
  - **sudo**: 2x `Esc` schaltet `sudo` für den aktuellen Befehl an bzw. aus.
  - git
  - npm
  - tarruda/zsh-autosuggestions
- Prompt mit folgenden Funktionen:
  - Git-Integration
  - Anzeige des Exit-Codes
  - Anzeige der Zeit die ein Befehl benötigt hat
  - Font Awesome-Icons mit Erkenung des Systemtyps
- Haufenweise Aliase für `ls` (`ll` = Tabelle, `la` = versteckte Dateien)
- Wenn `exa` installiert ist wird es statt `ls` verwendet
- `become <user>` ist Alias für `sudo -iu <user>` (Login-Shell)
- `transfer <filename>` für Upload zu https://transfer.sh
- `qbin <filename>` für Upload zu https://qbin.io (`<command> | qbin -` für Upload von STDIN)

# micro-Konfiguration
- default-light Farbschema; ohne Hintergrund und Zeilenhervorhebung für beste Geschwindigkeit per SSH.
- comment-Plugin: mit Alt+# können Zeilen ein-/auskommentiert werden.
- `.editorconfig`-Unterstützung
- filemanager-Plugin (`F6`)
- Zeilen/Zeichen zählen (`F5`)

# vim-Konfiguration
- Lightline zeigt alle wichtigen Informationen in der Fußzeile an.
- Lastplace merkt sich die Eingabeposition.
- Farbschema: Brighton Lite; ohne Hintergrund und Zeilenhervorhebung für beste Geschwindigkeit per SSH.
- Datei mit root-Rechten speichen (per sudo) mit `:w!!`.

# tmux-Konfiguration
- Maussteuerung ist aktiviert.
- Unauffälliges Design.

## Tastenkombinationen

Kommandosequenz: `Strg + Leertaste`

Kürzel     |Beschreibung
-----------|------------
`←↓↑→`     |Panel auswählen
`Strg+←↓↑→`|Panel vergrößern/verkleinern
`-`        |Horizontal teilen
`<`        |Vertikal teilen (in deutschem Tastaturlayout selbe Taste wie `|`)
`t`        |Neuer Tab
`,`        |Zu vorigem Tab wechseln
`.`        |Zu nächstem Tab wechseln
`1`-`9`    |Zu bestimmtem Tab wechseln
`r`        |Konfiguration neu laden
