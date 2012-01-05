source ~/dotfiles/zsh/config.sh

### Aliases ###

# Edit this file.
alias ez='$EDITOR ~/.zshrc; reload'

# Shortcuts
alias wiki="open https://sysiwiki.aghq.net/"

# Include ~ in CDPATH to nav from anywhere
CDPATH='.:~:/Volumes'

# Uppercuts
alias ..='cd ..'
alias ../..='..;..'
alias ../../..='..;..;..'
alias ../../../..='..;..;..;..'
alias ../../../../..='..;..;..;..;..'

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

# Git
alias g=git\ status\ -s
alias gco=git\ checkout
alias gb=git\ branch
alias g/='cd ./$(git rev-parse --show-cdup)' # Go to the root of the git project.
alias cdg=g/
alias gd=git\ diff\ -w
alias ga=git\ add
alias gcm=git\ commit
alias gitx="open /Applications/GitX.app"
alias gl="git log --oneline"
alias gg="git log --graph --all --oneline"

# Remove trailing whitespace
alias rtwc='rtw `g | sed "s/^.\{3\}//"`'

# Misc
alias notes='echo $(printf "~/notes/blake/%s" $*)'
alias reload='source $ALAISES_PATH'
alias l=ls\ -l
alias recent='ls -lt | head -n 20'
alias c=clear
alias cl=c\;l

# Rails
alias s='rails server'
alias shin='rails server thin'
alias rt='ruby -I"lib:test"'

# Turn this into a function, if the file does not exisit, create it.
alias todo='open ~/notes/todo/$(basename `pwd`)'

# Unmount disk
alias um='diskutil umount'

# Journal Aliases
alias grep-journal='cat ~/notes/blake/journal.txt | grep'

alias undormrf='mv /tmp/rmrf/* .'

# Gist Stash
# alias gist-stash='git diff --cached --binary | gist -po -t diff'
# The above would be better, but right now the extension is being ignored soo the below works in the mean time.
alias gist-stash='git diff -w --cached --binary > patch.diff;gist patch.diff;rm patch.diff'

# Print status
alias status='echo $?'

alias job_count='jobs | wc -l | sed -e "s/^[ \t]*//"'

alias b=bookmark

alias unit='rake test:units'
alias functional='rake test:functionals'
alias u=unit
alias f=functional
alias amend='git commit --amend'
# work on this, alias functional='ruby test/functionals/$@'

alias ip='ifconfig en0 | grep inet | cut -c 7-15'
alias exip='curl icanhazip.com'

alias cuke=cucumber

# Ruby Bundles
alias be=bundle\ exec
alias rspec=be\ rspec
alias rake=be\ rake

alias stage='git push stage head:master'
alias browse=hub\ browse
alias jinkies='open http://jinkies.heroku.com/job/$(vcprompt -f "%b")'

# Link schema example to schema
alias scln='ln -Ff db/schema.example.rb db/schema.rb'

alias migrate='rake db:migrate db:test:load'

# Github Style Branch Listing. Need to clean up and make faster
alias branches='git for-each-ref --count=400 --sort=-committerdate refs/heads/ --format='"'"'printf "%%-40s %%4d behind\t%%4d ahead\t%%-20s\t%%30s\n" "$(echo %(refname) | cut -d / -f 3-)" "$(echo $(git log %(objectname)..master --oneline | wc -l))" "$(git log master..%(objectname) --oneline | wc -l)" "%(authorname)" "%(authordate)"'"'"' | $SHELL | less'
alias b=branches


### Functions ###

# Back something up.
backup(){
  z ~/Archives/Backups/$1@$(date +%Y)$(date +%m)$(date +%d).tgz $1
}

# :nodoc:
show_doc(){
  rocco -o doc $1
  open $(echo "doc/${1}" | sed s/\\..\*/\.html/)
}

# Make so ctrl-z toggles running process.
# ctrlz () {
#  if [[ $#BUFFER -eq 0 ]]; then
#    fg
#    zle redisplay
#  else
#    zle push-input
#  fi
#}
#zle -N ctrlz
#bindkey '^Z' ctrlz

printn(){
  echo $(printf "$1%.0s" {0..$2})
}


remove_project_trailing_whitespace(){
  for file in * (app|config|test|lib|public)/**/*.(rb|js|sass|css|yml|md|txt|erb|haml|config)
  do
    sed -i "" 's/[[:space:]]*$//' ${file}
    sed -i "" -e :a -e '/^\n*$/N;/\n$/ba' ${file}
  done
}

unit-open(){
  echo $BOOKMARK_PATH[$1] -l $BOOKMARK_LINE[$1]
}

#rake(){
#  command rake "$@" | bookmark
#}


# Should print one line for ever hash tag that is found in the file, I probably need sed for this
#alias journal-tags='cat '
ls-journal-tags() {
  sed 's/#[a-z,A-Z]*/^&^/g' ~/notes/blake/journal.txt | tr -s '^' "\n" | grep "^#" | sort | uniq
}
# Removes trailing white space from files.
#
# Examples:
#  rtw `files db lib test app config public` # to remove trailing whitespace from all files in a rails app.
rtw () {
  sed -i "" 's/[[:space:]]*$//' $*
  sed -i "" -e :a -e '/^\n*$/N;/\n$/ba' $*
}

# TODO, fix so it work from any place, not just the root of the git repo, seems like this identifies files that don't have whitespace issues too.
hastw () {
  git diff-index --check --cached HEAD | sed '/^[+1]/d' | sed 's/\:[0-9]*\:.*//' | uniq
}

# This one has no limit but should be slower, set up to use this as a fall back perhaps if the first one fails?
#rtw () {
#  for f in $*
#  do
#    sed -i "" 's/[[:space:]]*$//' $f
#  done
#}

# Identifies files with trailing white space.
tw () {
  grep -l '[[:space:]]*$' $*
}

ff () {
  # ff x find file named x
  find . -name $1 -print
}

# Finds all files not in hidden directories, includes files that are hidden.
files () {
  find $* \( ! -regex '.*/\..*/..*' \) -type f -print
}

rails () {
  if [ -e script/server ]; then
    script/"$@"
  else
    command rails "$@"
  fi
}

# NOTE: This method is still unsafe. Add checks to ensure you can only use this on file or folder directly in
#       the current directory. This will prevent removing this like root and ensure that a subsequent
#       undormrf will work correctly
rmrf () {
  rm -rf /tmp/rmrf
  mkdir -p /tmp/rmrf
  mv "$@" /tmp/rmrf
}


bare_repo() {
  mkdir $1.git
  cd $1.git
  git --bare init
  cd ..
}

# Setup tunnel to rackspace and tab-completion for server names.
rackspace () {
  ssh -A -t rackspace.aghq.net ssh "$@"
}

## RVM
function gemdir {
  if [[ -z "$1" ]] ; then
    echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
  else
    rvm "$1"
    cd $(rvm gemdir)
    pwd
  fi
}

bucky() {  # http://en.wikipedia.org/wiki/Bucky_bit
cat <<eof
  command | ⌘ | cmd
  control | ⌃ | ctrl
  option  | ⌥ | opt
  alt     |   | alt
  shift   | ⇧ | shift
eof
}


# Clean a commit removing fivolous whitespace.
git_union() {
  PATCH=`mktemp /tmp/diff.XXXXX`
  CPATCH=`mktemp /tmp/diff.XXXXX`
  git diff -w --binary head > $PATCH
  git diff --binary --cached > $CPATCH
  git reset --hard HEAD
  git apply $PATCH
  git apply --cached $CPATCH
  rm $PATCH $CPATCH
}

gist-apply(){
  curl $1 | git apply
}

# function to change directory to the one set in the last opened finder.
cdf () {
   currFolderPath=$( /usr/bin/osascript <<EOT
       tell application "Finder"
           try
               set currFolder to (folder of the front window as alias)
           on error
               set currFolder to (path to desktop folder as alias)
           end try
           POSIX path of currFolder
       end tell
EOT
   )
   echo "cd to \"$currFolderPath\""
   cd "$currFolderPath"
}

# open textmate project
function mate(){
  local proj=$(basename `pwd`).tmproj
  if [ $# -eq 0 ]; then
    if [ -f $proj ]; then
      open $proj
    else
      command mate
    fi
  else
    # If the params equals ., check for project file with name match directoy and open that if it's there.
    if [ "$@" = '.' -a -f $proj ]; then
      open $proj
    else
      command mate "$@"
    fi
  fi
}

