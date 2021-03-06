### Aliases ###

# Easy editing of aliases and functions
alias ea='vi ~/.zsh/aliases.zsh'
alias ef='vi ~/.zsh/functions.zsh'

# Convenience alias for vagrant
alias v=vagrant

# Review some commits
alias logme='git log --all --since="6am" --until="today" --format="[%h]  %s %an" | grep $@ -i'
#alias logcount='$(logme $@) | wc'

# Commit with message
alias cm='git commit -m'

# Clean out pesky assets.
alias clean_assets='rm -rf public/javascripts/compiled public/stylesheets/compiled public/assets'

# Easy access to git recent
alias gr=git\ recent

# Take a hexdump
alias hd=hexdump\ -C

# Super short aliases
alias b=branch-status
alias bm=branch-status-base-master
alias n=nbx
alias a=git\ add
alias aa='git add -A && git status -s' # Add all

# Edit this file.
alias ez='$EDITOR ~/.zshrc; reload'

# Shortcuts
alias wiki="open https://sysiwiki.aghq.net/"

# Include ~ in CDPATH to nav from anywhere
CDPATH='.:~:/Volumes'

# Fat finger
alias cd..='cd ..'

# Compression
alias z='tar czf' # z [output_name.tgz] dir
alias uz='tar xzf' # uz intput.tgz

# SSH
alias authkey='cat ~/.ssh/id_rsa.pub | ssh $1 "cat >> ~/.ssh/authorized_keys"'

# SSH Tunnels
alias terremark='ssh -A -t terremark.aghq.net ssh "$@"'

compctl -k "(meat-boy,francis,ellis)" rackspace

# Utility
alias guid=uuidgen

# Hide a folder from finder.
alias hide='SetFile -a "V" $1'

# Get it?
alias ellis=ls

# I bet Ellis gets it...

# Easy hop into the dotfiles directory
# TODO: Auto figure this location...
alias dotfiles=pushd\ ~/Projects/dotfiles

# Git
alias gl="git short"
alias gg="git short --graph"
alias gco=git\ checkout
alias gb=git\ branch
alias show=git\ show\ head

# Go to project root
alias g/=cd $(git root)
alias cdg=g/

# Show uncached differences without whitespace.
alias xx=git\ diff\ -w
alias x=xx

# Show cached changes
alias xc=git\ diff\ --cached

# Compare working directory to head
alias xa=git\ diff\ head

alias gitx="open /Applications/GitX.app"

# Github Style Branches
alias branch-status='git for-each-ref --count=400 --sort=-committerdate refs/heads/ --format='"'"'printf "%%-40s %%4d behind\t%%4d ahead\t%%-20s\t%%30s\n" "$(echo %(refname) | cut -d / -f 3-)" "$(echo $(git log %(objectname)..head --oneline | wc -l))" "$(git log head..%(objectname) --oneline | wc -l)" "%(authorname)" "%(authordate)"'"'"' | $SHELL | less'

# Branch status, but use master as base
alias branch-status-base-master='git for-each-ref --count=400 --sort=-committerdate refs/heads/ --format='"'"'printf "%%-40s %%4d behind\t%%4d ahead\t%%-20s\t%%30s\n" "$(echo %(refname) | cut -d / -f 3-)" "$(echo $(git log %(objectname)..master --oneline | wc -l))" "$(git log master..%(objectname) --oneline | wc -l)" "%(authorname)" "%(authordate)"'"'"' | $SHELL | less'

# Remove trailing whitespace
alias rtwc='rtw `g | sed "s/^.\{3\}//"`'

# Misc
alias reload='source ~/.zshrc'
alias l=ls\ -l
alias recent='ls -lt | head -n 20'
alias c=clear
alias cl=c\;l

alias todos='open ~/todos/master.taskpaper'

# Unmount disk
alias um='diskutil umount'

# Give one shot to undo rmrf.
alias undormrf='mv /tmp/rmrf/* .'

# Gist Stash
# alias gist-stash='git diff --cached --binary | gist -po -t diff'
# The above would be better, but right now the extension is being ignored soo the below works in the mean time.
alias gist-stash='git diff -w --cached --binary > patch.diff;gist patch.diff;rm patch.diff'

# Print status
alias status='echo $?'

alias job_count='jobs | wc -l | sed -e "s/^[ \t]*//"'

alias amend='git commit --amend'

alias ip='ifconfig en0 | grep inet | cut -c 7-15'
alias exip='curl icanhazip.com'

alias cuke=cucumber

alias stage='git push stage head:master'
alias gu=git_union
alias browse=hub\ browse
alias jinkies='open http://jinkies.heroku.com/job/$(vcprompt -f "%b")'

# Link schema example to schema
alias scln='ln -Ff db/schema.example.rb db/schema.rb'

alias migrate='zeus rake db:migrate db:test:load'

alias migrate_last='zeus rake db:migrate:up VERSION=$(latest_migration)'
alias rollback_last='zeus rake db:migrate:down VERSION=$(latest_migration)'

alias tp='heroku logs --tail --app $PROD'
alias prod='heroku console --app $PROD'

alias bgl=BUNDLE_GEMFILE=Gemfile.local

alias td='tail -n 100 log/development.log'
alias tdf='tail -f log/development.log'

alias sl=git\ stash\ list

alias t=thor

alias google=git\ grep

# Pretty print json.
#
# Usage:
#
# $ curl -s some/json/end.point | json
# {
#   "key": "value"
# }
#
# [More…](http://stackoverflow.com/questions/352098/how-to-pretty-print-json-script)
#
alias json=python\ -mjson.tool
alias jscolor='pygmentize -f terminal256 -l javascript -O style=native'

#When I know the file I want to edit is the most recent file in a directory
alias vew='vi `l\s -t * | head -1 `'

# Deploy helpers
alias ckmigs='git diff production/master..HEAD db'

# Rails
alias s='zeus server'
alias rc='zeus console'

# Open last file edited in vim.
alias lvim='vim -c "normal '\''0"'

# Unmounts my sneaker drive
alias ums=unmount_sneaker
alias umb=unmount_backup

# Change to desktop
alias desk='cd ~/Desktop'

# Open ledger
alias ol='mvim ~/Ledgers/general.ldg'
alias ldg=ledger

# Print ledger balances
alias bal='ledger -f ~/Ledgers/general.ldg bal'
alias bals='ledger -f ~/Ledgers/general.ldg -s bal'
