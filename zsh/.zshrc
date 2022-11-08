#!/bin/sh

# set zdotdir
export ZDOTDIR=$HOME/.config/zsh

# History in cache directory:
HISTFILE=~/.cache/zsh/history 
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete correctall
setopt interactive_comments
setopt histignorealldups sharehistory
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP


# Set up the prompt
# Enable colors 
autoload -U colors && colors

# tab completions
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

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-exports"
zsh_add_file "zsh-prompt"
zsh_add_file "functions.zsh"
zsh_add_file "envrc"
zsh_add_file ".zshenv"
zsh_add_file "zsh-aliases"

# start proxy redirection
setproxy

# fzf
[ -f ~/.fzf/shell/completion.zsh ] && source ~/.fzf/shell/completion.zsh  
[ -f ~/.fzf/shell/key-bindings.zsh ] && source ~/.fzf/shell/key-bindings.zsh 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fuck
eval $(thefuck --alias fuck)

# source ~/.config/zsh/theme/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Plugins
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions


compinit

# Key-bindings
# `showkey -a` to see the key code
bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest
bindkey '^X' autosuggest-execute
bindkey "^N" history-search-forward # without omitting your typed words
bindkey "^P" history-search-backward # without omitting your typed words
# bindkey '^E' autosuggest-accept
bindkey -M menuselect '\e' send-break
bindkey -s '^o' 'vifm^M'
# bindkey -s '^f' 'zi^M'
# bindkey -s '^z' 'zi^M'
# bindkey -s '^n' 'nvim $(fzf)^M'
# bindkey -s '^v' 'nvim\n'
# bindkey '^[[P' delete-char  # shift + p
# bindkey -r "^u"
# bindkey -r "^d"

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Environment variables set everywhere
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="google-chrome"
fpath+=${ZDOTDIR:-~}/.zsh_functions
