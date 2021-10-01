# Bash history settings                                                         

export HISTSIZE=-1         # set the limit of commands shown by the history command to unlimited
export HISTFILESIZE=-1        # set the limit of commands saved in .bash_history to unlimited
export HISTTIMEFORMAT="%F %T -> "    # enable the recoding of the timestamp and format it as "YYYY-MM-DD HH:MM:SS -> "
export HISTCONTROL=ignoreboth    # set to omit lines that start by a space or that match the previous command
export HISTIGNORE="ls*:la*:history:clear:ct:h:c"    # set to ignore specific commands
                                                                                
# To make bash append lines to the history rather than overwrite it             
shopt -s histappend                                                             
                                                                                
# By default, the history is kept only in memory while a session is running and is saved on exit
if [[ ! $PROMPT_COMMAND =~ 'history -a' ]]; then
    # PROMPT_COMMAND="history -a; $PROMPT_COMMAND"    # will immediately append new lines to the history file that were not already saved
    PROMPT_COMMAND="history -w; $PROMPT_COMMAND"    # will overwrite the history in the HISTFILE with the list from memory. 
fi

