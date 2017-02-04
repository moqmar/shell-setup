export ANTIGEN_DEFAULT_REPO_URL=https://github.com/robbyrussell/oh-my-zsh.git
source ~/.antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES

extract  # Helper for extracting different types of archives.

command-not-found  # Try to find a package which contains the command
colored-man-pages

sudo  # Double-Escape to toggle sudo
git   # Git aliases
npm   # npm aliases and completion

EOBUNDLES
antigen theme robbyrussell
antigen apply

unsetopt correct
setopt no_share_history

# ^0 to redirect errors to /dev/null
# >0 to redirect output to /dev/null
# »0 to redirect all to /dev/null
alias -g "^0=2>/dev/null"
alias -g ">0=>/dev/null"
alias -g "»0=>/dev/null 2>&1"

# https://gist.github.com/moqmar/656453680f72d324cc718285c108b6b2
function zsh-git-status() { if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1;then return 1;fi;git rev-parse @{u} >/dev/null 2>&1;HAS_REMOTE=$?;ZSH_GIT_REMOTE_STATUS="";if [ $HAS_REMOTE -eq 0 ];then LOCAL=$(git rev-parse @ 2>/dev/null);REMOTE=$(git rev-parse @{u} 2>/dev/null);BASE=$(git merge-base @ @{u} 2>/dev/null);if [ $LOCAL = $REMOTE ];then ZSH_GIT_REMOTE_STATUS="%{$fg_no_bold[green]%}$(zsh-fontawesome  "[OK]") ";elif [ $LOCAL = $BASE ];then ZSH_GIT_REMOTE_STATUS="%{$fg_no_bold[yellow]%}$(zsh-fontawesome  "[-]") ";elif [ $REMOTE = $BASE ];then ZSH_GIT_REMOTE_STATUS="%{$fg_no_bold[yellow]%}$(zsh-fontawesome  "[+]") ";else ZSH_GIT_REMOTE_STATUS="%{$fg_no_bold[red]%}$(zsh-fontawesome  "[!!!]") ";fi;fi;if [ $(git status --porcelain | wc -l) -gt 0 ];then echo -n "  $ZSH_GIT_REMOTE_STATUS%{$fg_bold[red]%}$(git symbolic-ref --short -q HEAD)";else echo -n "  $ZSH_GIT_REMOTE_STATUS%{$fg_bold[green]%}$(git symbolic-ref --short -q HEAD)";fi;}

function zsh-is-root() { [ "$(id -u)" = "0" ] && echo -n "$1" || echo -n "$2"; return $? }
function zsh-fontawesome() { [ "$FONTAWESOME" = "" ] && echo -n "$1" || echo -n "$2" }
function zsh-icon() {
    icon="? "
    [ -e /sys/class/power_supply/BAT0 ] && icon="%{$fg_bold[green]%}$(zsh-fontawesome " " "[L]") " || icon="%{$fg_bold[blue]%}$(zsh-fontawesome " " "[D]") "
    [ -d /etc/X11 ] || icon="%{$fg_bold[yellow]%}$(zsh-fontawesome " " "[S]") "
    [ -f /usr/bin/raspi-config ] && icon="%{$fg_bold[red]%}π "
    [ -d /data/app ] && icon=""
    echo -n $icon
}

PROMPT='$(zsh-icon)$([ -d /data/app ] || zsh-is-root "%{$fg_bold[red]%}%n%{$fg_bold[grey]%}@%M " "%{$fg_bold[grey]%}%n@%M ")%{$fg_bold[yellow]%}%(4~|…/%2~|%~) %{$fg_bold[$([ "$(id -u)" = "0" ] && echo red || echo blue)]%}$(zsh-is-root "#" \$) %{$reset_color%}'
RPROMPT='$(ZSH_LAST_STATUS=$?;[ $ZSH_LAST_STATUS -eq 0 ] || echo "%{$fg_no_bold[red]%}$(zsh-fontawesome " ")$ZSH_LAST_STATUS")$(zsh-git-status)%{$reset_color%}'

transfer() { if [ $# -eq 0  ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi; tmpfile=$( mktemp -t transferXXX  ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

export EDITOR=vim
