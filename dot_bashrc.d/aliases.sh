# aliases

# ls
alias ls="ls -h --color=auto"
alias la="ls -ha --color=auto"
alias ll="ls -halF --color=auto"

# quick tools
alias c="clear"
alias mkdir="mkdir -vp"
alias h="history"
alias hg="history | grep"
alias df="pydf"
alias rm='rm -iv'
alias rmy='\rm -v'
alias r='ranger'
alias neo='neofetch'

# navigation
alias ..="cd .."
alias ...="cd ../../.."
alias ....="cd ../../../.."

# package manager
alias update="sudo dnf update"
alias updatey="sudo dnf update -y"

# nvim
alias vim='nvim'
alias vi='nvim'

# git
alias gdone="git push"

# script to quickly switch from gnome-terminal to terminator
alias ct="change_terminal gnome-terminal terminator"

# chmod
alias chmod="chmod -v"

# chezmoi aliases
alias cz='chezmoi'
alias czs='chezmoi status'
alias cza='chezmoi re-add'
alias czm='chezmoi managed'
alias czg='chezmoi git'
alias czd='chezmoi diff'
alias czcd='chezmoi cd'

