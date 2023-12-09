#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# General bash aliases
alias ls='ls --color=auto'
alias lsa='ls -a'
alias lsr='ls -R'
alias grep='grep --color=auto'
alias rmf='rm -rf'

# Python virtual environment (creation and activation)
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'

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

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH



# Created by `pipx` on 2023-09-19 11:15:02
export PATH="$PATH:/home/jane/.local/bin"
