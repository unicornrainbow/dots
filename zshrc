#! /usr/bin/env zsh

# Source oh-my-zsh if it is installed.
if [[ -d $HOME/.oh-my-zsh ]]; then
  # Path to your oh-my-zsh configuration.
  ZSH=$HOME/.oh-my-zsh

  # Set name of the theme.
  ZSH_THEME="blakefrost"

  # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
  # Example format: plugins=(rails git textmate ruby lighthouse)
  plugins=(vi-mode rvm ruby rails autojump bundler brew gem heroku history-substring-search)

  # Comment this out to disable weekly auto-update checks
  DISABLE_AUTO_UPDATE="true"

  # Load default oh-my-zsh stuff
  source $ZSH/oh-my-zsh.sh
fi

# Disable auto correct
unsetopt correct_all

## ls colors for osx
if [[ "$(which gls)" != "gls not found" ]]; then
  eval `gdircolors`
  alias ls='gls -hF --color=auto'
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

## Use mvim in console mode
alias vim='mvim -v'

# Setup Path
export PATH=~/script:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:.:~/bin:~/.rbenv/bin

# Add node share to path
export PATH=/usr/local/share/npm/bin/:$PATH

# Add python share to path
export PATH=/usr/local/share/python:$PATH

# Include gem directory in path and setup RVM. Also add current directory to path.
export PATH=`gem env gemdir`:$PATH

# Setup Notebox notes root to ~/Notes
export NBX_NOTES_ROOT=~/Notes

# RE: Lion Rubies Breaks Ruby and RVM
# > Notes for Darwin ( Mac OS X )
# >   For Lion, Rubies should be built using gcc rather than llvm-gcc. Since
# >   /usr/bin/gcc is now linked to /usr/bin/llvm-gcc-4.2, add the following to
# >   your shell's start-up file: export CC=gcc-4.2
# >   (The situation with LLVM and Ruby may improve. This is as of 07-23-2011.)
export CC=gcc-4.2

# Initialize rebenv
[[ "$(which rbenv)" != "rbenv not found" ]] && eval "$(rbenv init -)"

# Configure node
export NODE_PATH=/usr/local/lib/node

# Hold onto history for a while.
export HISTSIZE=1000000

# Ruby
export RUBYLIB="lib:test"

# Set editors
export EDITOR=mvim\ -v

# Default ledger file
export LEDGER_FILE=~/Ledgers/general.ldg

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

# COMPLETION SETTINGS
# add custom completion scripts
fpath=(~/.zsh/completion $fpath)

# compsys initialization
autoload -U compinit
compinit

# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2

# Load all other scripts.
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
