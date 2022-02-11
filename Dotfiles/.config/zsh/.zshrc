#!/bin/sh
export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

#BEEP is shit
unsetopt BEEP

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

#Useful files to source
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"
zsh_add_file "vim-mode"
zsh_add_file "zsh-exports"
zsh_add_file ".zsh-icons"

#Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-completions"
zsh_add_plugin "hlissner/zsh-autopair"

source $HOME/antigen.zsh

#TODO: Make add theme function
#git clone https://github.com/spaceship-prompt/spaceship-prompt.git --depth=1
antigen theme spaceship-prompt/spaceship-prompt
antigen apply

#Keybindings
bindkey '^ ' autosuggest-execute
bindkey '^n' autosuggest-accept

# Environment variables set everywhere
export EDITOR="nvim"
export TERMINAL="alacritty"

