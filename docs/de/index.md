---
description: Übersicht über shell-setup und bootstrap.sh
next: /shell-setup.html
nextTitle: Das shell-setup Repository
---
# Was ist shell-setup?

shell-setup ist eine Sammlung aller Konfigurationsdateien für meine Linux-Terminal-Umgebung.  
Es gibt passend dazu das Skript [bootstrap.sh](https://gist.github.com/moqmar/7b468d995619131e983d59bde253d9a0), welches einen voll funktionsfähigen Debian-Server so wie ich ihn mag aufsetzt.

Das heißt, das ganze Projekt ist ziemlich subjektiv. Ich mag einfache, platzsparende und benutzerfreundliche Konfigurationen (aus Sicht eines GNOME-Nutzers, ich weiß dass Menschen die Emacs als Desktopumgebung verwenden eine andere Ansicht dazu haben, was benutzerfreundlich ist und was nicht).

Wenn du das auch so magst, wäre das perfekt, aber vielleicht möchtest du auch [das Repository forken](https://github.com/moqmar/shell-setup#fork-destination-box) und deine eigene Version bauen. Mein Ziel ist nicht nur meine Konfiguration zu teilen, sondern auch einen einfachen Workflow zur Verfügung zu stellen, um ein neues System schnell und einfach an die eigenen Vorlieben anzupassen.

## Nutzerkonfiguration

Momentan sind Konfigurationsdateien für die folgende Software dabei:
- **zsh**: Ein sehr guter Bash-Ersatz mit vielen guten Plugins.
- **tmux**: Ein Terminal-Multiplexer.
- **vim**: Ein Kommandozeilen-Texteditor, der für so gut wie jedes System verfügbar ist.
- **micro**: Ein kleiner Texteditor mit intuitiver Bedienung (Maus, Strg+S, ...).
- **ssh**: Erstellt einen SSH-Schlüsel und richtet die Ordnerberechtigungen ein.

![](zsh.jpg)

![](tmux-vim-micro.jpg)

### Konfiguration manuell anwenden

```bash
$ git clone https://github.com/moqmar/shell-setup.git ~/.shell-setup
$ cd .shell-setup
$ make install
```

Siehe auch die [erweiterte Dokumentation](shell-setup.md) für mehr Informationen zum Anwenden und Verändern der Konfiguration.

## Das Bootstrap-Skript

Aktuell ist das Skript in der Lage, die folgenden Dinge einzurichten (das Skript wird vor jedem Schritt fragen, ob er ausgeführt werden soll):
- **locales**: Auswahl der korrekten Lokalisierung für den Server.
- **apt: upgrade**: Paketliste aktualisieren und auf die neueste Version aller Pakete updaten.
- **apt: install basic tools**: vim, git, build-essential, zip/unzip, tar, htop, wget, curl, dnsutils
- **apt: install additional tools**: zsh, tmux, mosh, ag, jq
- **install binary tools**: micro, exa, fd
- **user configuration**: shell-setup für den aktuellen Nutzer anwenden.
- **default for new users**: shell-setup immer für neue Nutzer anwenden.
- **clear motd, colored bash prompt**
- **sshd config**: Passwort-Authentifizierung verbieten und `/etc/ssh/sshd_config` auf sinnvolle Standardwerte setzen.
- **quad9 nameserver**
- **basic iptables ruleset**: SSH, Mosh und Netzwerkrelevante Protokolle (ping, traceroute, dhcp) erlauben
- **caddy**: Benutzerfreundlicher Webserver, kann optional auch mit PHP installiert werden.

Es gibt eine [detaillierte Dokumentationsseite zu bootstrap.sh](bootstrap.md) mit mehr Informationen darüber, welche Änderungen jeder der Schritte auf einem System bewirkt.

### Verwendung des Bootstrap-Skripts

```bash
$ bash -c ". <(curl -s https://gist.githubusercontent.com/moqmar/7b468d995619131e983d59bde253d9a0/raw)"
```
