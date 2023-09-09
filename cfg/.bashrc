#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# General bash aliases
alias ls='ls --color=auto'
alias lsr='ls -R'
alias grep='grep --color=auto'
alias rmf='rm -rf'

# Python virtual environment (creation and activation)
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# NVM - Node aliases
alias na='nvm use node'
alias ninst='nvm install node'



# Tar utils
alias untar='tar xzvf'
alias tarup='tar czvf'

# Initialize starship for bash
eval "$(starship init bash)"

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
. /usr/share/bash-completion/bash_completion


# Path variables
export PATH="$PATH:/home/$HOME/.local/bin:~/.console-ninja/.bin"
PATH=~/.console-ninja/.bin:$PATH