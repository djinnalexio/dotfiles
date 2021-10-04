# aliases
                                                                       
alias ct=" ~/.local/bin/change_terminal.sh"                                     
                                                                                
alias ls="ls -h --color=auto"
alias la="ls -ha --color=auto"                                                               
alias ll="ls -halF --color=auto" 
                                                                               
alias c="clear"                                                                 
alias h="history"                                                               
                                                                                
alias ..="cd .."                                                                
alias ...="cd ../../.."                                                         
alias ....="cd ../../../.."                                                     

alias mkdir="mkdir -vp"

alias hg="history | grep"                                                       
alias df="pydf"                                                                 
                                                                                
alias update="sudo dnf update"                                                       
alias updatey="sudo dnf update -y"                                                   
                                                                                
alias rm='rm -iv'
alias rmy='rm -v'

alias vim='nvim'

# in case I need to manually fix the prompt format
alias ps1fix='export PS1="\[\e[35m\][\[\e[m\]\[\e[35m\]\A\[\e[m\]\[\e[35m\]]\[\e[m\]\[\e[35m\] \[\e[m\]\[\e[35m\]\W\[\e[m\]\[\e[35m\] \[\e[m\]\[\e[35m\]\\$\[\e[m\] "; clear'

# chezmoi aliases
alias cz='chezmoi'
alias cza='chezmoi re-add'
alias czm='chezmoi managed'
alias czg='chezmoi git'
alias czd='chezmoi diff'
alias czcd='chezmoi cd'
