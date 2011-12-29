setopt prompt_subst
PROMPT='%n@%m:%~ $(vcprompt -f "[%s:%b] ") $(printn "★ " $(job_count)) '
# export RPROMPT='$(echo $RUBY_VERSION | sed "s/\([a-z]*\)-\([1-9\.]*\)\(.*\)/\1 \2/" | tr a-z A-Z)'
export RPROMPT='$(rbenv version | cut -d " " -f 1 | sed "s/-/ /g")'

# ✪ ★
## Completions
autoload -U compinit
compinit -C

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## Global options
setopt correct

## Allow interactive comments
setopt interactivecomments

## Spelling prompt
SPROMPT='zsh: correct '%R' to '%r' ? ([Y]es/[N]o/[E]dit/[A]bort) '

## Allow tabbing backwards through tab completion.
# From: http://bit.ly/aII3Fm
bindkey '^[[Z' reverse-menu-complete

# VI Keybindings
# bindkey -v
