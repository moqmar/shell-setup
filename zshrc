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

tarruda/zsh-autosuggestions

EOBUNDLES
antigen theme robbyrussell
antigen apply

unsetopt correct
setopt no_share_history

# https://gist.github.com/moqmar/656453680f72d324cc718285c108b6b2
function zsh-git-status(){ if ! git rev-parse --is-inside-work-tree>/dev/null 2>&1;then return 1;fi;git rev-parse @{u}>/dev/null 2>&1;HAS_REMOTE=$?;ZSH_GIT_REMOTE_STATUS="";if [ $HAS_REMOTE -eq 0 ];then LOCAL=$(git rev-parse @ 2>/dev/null);REMOTE=$(git rev-parse @{u} 2>/dev/null);BASE=$(git merge-base @ @{u} 2>/dev/null);if [ $LOCAL = $REMOTE ];then ZSH_GIT_REMOTE_STATUS="%{$fg_no_bold[green]%} ";elif [ $LOCAL = $BASE ];then ZSH_GIT_REMOTE_STATUS="%{$fg_no_bold[yellow]%} ";elif [ $REMOTE = $BASE ];then ZSH_GIT_REMOTE_STATUS="%{$fg_no_bold[yellow]%} ";else ZSH_GIT_REMOTE_STATUS="%{$fg_no_bold[red]%} ";fi;fi;if [ $(git status --porcelain 2>/dev/null|wc -l) -gt 0 ];then branch=`git symbolic-ref --short -q HEAD 2>/dev/null`;[ -z "$branch" ]&&branch=`git rev-parse --short HEAD 2>/dev/null`;echo -n "  $ZSH_GIT_REMOTE_STATUS%{$fg_bold[red]%}$branch";else branch=`git symbolic-ref --short -q HEAD 2>/dev/null`;[ -z "$branch" ]&&branch=`git rev-parse --short HEAD 2>/dev/null`;echo -n "  $ZSH_GIT_REMOTE_STATUS%{$fg_bold[green]%}$branch";fi;}
function zsh-is-root() { [ "$(id -u)" = "0" ] && echo -n "$1" || echo -n "$2"; return $? }
function zsh-fontawesome() { [ "$FONTAWESOME" = "" ] && echo -n "$1" || echo -n "$2" }
function zsh-icon() {
    icon="? "
    [ -e /sys/class/power_supply/BAT0 ] && icon="%{$fg_bold[green]%}$(zsh-fontawesome " " "[L]") " || icon="%{$fg_bold[blue]%}$(zsh-fontawesome " " "[D]") "
    [ -z "$XDG_SESSION_TYPE" ] && icon="%{$fg_bold[yellow]%}$(zsh-fontawesome " " "[S]") "
    [ -f /usr/bin/raspi-config ] && icon="%{$fg_bold[red]%}π "
    [ -d /data/app ] && icon=""
    echo -n $icon
}
function zsh-commandtime() {
    [ "$commandtime_state" = "display" ] || return
    t=$(($commandtime_timer+$SECONDS))
    if [ $t -gt 2 ] && [ $t -lt 60 ]; then
        echo -n " %{$fg_bold[yellow]%}🕓%{$fg_no_bold[yellow]%}$t"s
    elif [ $t -gt 2 ]; then
        tz=
        [ $t -lt 10 ] && tz=0
        echo -n " %{$fg_bold[yellow]%}🕓%{$fg_no_bold[yellow]%}$(($t/60)):$tz$(($t%60))"
    fi
}
_commandtime_preexec() {
    commandtime_timer=$((-$SECONDS))
    commandtime_state="command"
}
_commandtime_precmd() {
    if [ "$timerstate" = "command" ]; then
        commandtime_state="display"
    else
        commandtime_state="prompt"
    fi
}
preexec_functions+=(_commandtime_preexec)
precmd_functions+=(_commandtime_precmd)

PROMPT='$(zsh-icon)$([ -d /data/app ] || zsh-is-root "%{$fg_bold[red]%}%n%{\e[1;90m%}@%M %{\e[0m%}" "%{\e[1;90m%}%n@%M %{\e[0m%}")%{$fg_bold[yellow]%}%(4~|…/%2~|%~) %{$fg_bold[$([ "$(id -u)" = "0" ] && echo red || echo blue)]%}$(zsh-is-root "#" \$) %{$reset_color%}'
RPROMPT='$(ZSH_LAST_STATUS=$?;[ $ZSH_LAST_STATUS -eq 0 ] || echo "%{$fg_no_bold[red]%}$(zsh-fontawesome " ")$ZSH_LAST_STATUS")$(zsh-commandtime)$(zsh-git-status)%{$reset_color%}'

export EDITOR=$(which micro >/dev/null && echo micro || { which vim >/dev/null && echo vim || echo nano })

which exa >/dev/null && {
    alias ls="exa"
    alias la="exa -a"
    alias ll="exa --git -la"
}

alias l="ll"
alias lsl="ls"
alias sls="ls"
alias lsls="ls"
alias sl="ls"

transfer() { if [ $# -eq 0  ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi; tmpfile=$( mktemp -t transferXXX  ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; echo; }
alias become="sudo -iu"
alias qbin="curl https://beta.qbin.io -s -T"
