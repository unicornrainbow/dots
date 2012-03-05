#! /usr/bin/env zsh

# VI Keybindings (Must come before sourcing oh-my-zsh to avoid stomp history-substring-search)
bindkey -v

# Source oh-my-zsh if it is installed.
if [[ -d $HOME/.oh-my-zsh ]]; then
  # Path to your oh-my-zsh configuration.
  ZSH=$HOME/.oh-my-zsh

  # Set name of the theme.
  ZSH_THEME="blakefrost"

  # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
  # Example format: plugins=(rails git textmate ruby lighthouse)
  plugins=(rvm ruby rails autojump bundler brew gem heroku history-substring-search)

  # Load default oh-my-zsh stuff
  source $ZSH/oh-my-zsh.sh
fi

## Colors
eval `gdircolors`
alias ls='gls -hF --color=auto'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

## Use mvim in console mode
alias vim='mvim -v'

# Setup Path
export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:.:~/bin

# Include gem directory in path and setup RVM. Also add current directory to path.
export PATH=`gem env gemdir`:$PATH

# RE: Lion Rubies Breaks Ruby and RVM
# > Notes for Darwin ( Mac OS X )
# >   For Lion, Rubies should be built using gcc rather than llvm-gcc. Since
# >   /usr/bin/gcc is now linked to /usr/bin/llvm-gcc-4.2, add the following to
# >   your shell's start-up file: export CC=gcc-4.2
# >   (The situation with LLVM and Ruby may improve. This is as of 07-23-2011.)
export CC=gcc-4.2

# Initialize rebenv
eval "$(rbenv init -)"

# Configure node
export NODE_PATH=/usr/local/lib/node

# Hold onto history for a while.
export HISTSIZE=1000000

# Ruby
export RUBYLIB="lib:test"

# Set editors
export EDITOR=mvim\ -v

## Completions
autoload -U compinit
compinit -C

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Turn on spelling correction
setopt correct

# Use extended globbing
setopt extendedglob

# Allow interactive comments
setopt interactivecomments

# Always pushd when changing directory
setopt auto_pushd

## Allow tabbing backwards through tab completion.
# From: http://bit.ly/aII3Fm
bindkey '^[[Z' reverse-menu-complete

# Tun on bash style incremental search
bindkey '^R' history-incremental-search-backward

# Pretty colors
export TERM='xterm-256color'

# Speed up git completion
# http://talkings.org/post/5236392664/zsh-and-slow-git-completion
__git_files () {
  _wanted files expl 'local files' _files
}

# Things I don't want to publish to github
[[ -s "$HOME/.secrets" ]] && source "$HOME/.secrets"

# Load all other scripts.
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/notes.zsh
