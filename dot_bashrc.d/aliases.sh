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
                                                                                
alias hg="history | grep"                                                       
alias df="pydf"                                                                 
                                                                                
alias update="dnf update"                                                       
alias updatey="dnf update -y"                                                   
                                                                                
alias rm='rm -iv'

# in case I need to manually fix the prompt format
alias ps1fix='export PS1="\[\e[35m\][\[\e[m\]\[\e[35m\]\A\[\e[m\]\[\e[35m\]]\[\e[m\]\[\e[35m\] \[\e[m\]\[\e[35m\]\W\[\e[m\]\[\e[35m\] \[\e[m\]\[\e[35m\]\\$\[\e[m\] "; clear'


alias cz='chezmoi'

alias vim='nvim'
