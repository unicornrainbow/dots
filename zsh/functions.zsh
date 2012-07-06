### Functions ###

fastpush() {
  git fetch $1
  git checkout $1/master
  git merge -
  local hash=$(git rev-parse HEAD)
  git checkout -
  git push $1 $hash:master
}

# Hop into a project directory
p() { cd ~/Projects/$1; }
_p() { _files -W ~/Projects -/; }
compdef _p p

# Print latest migration
latest_migration(){
  ls db/migrate/ |grep "^[0-9]" | tail -n 1 | awk -F'_' '{print $1}'
}

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
    bash -c "[ -f .env ] && source .env; command rails \"$@\""
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

# Checkout a previous branch
cop(){
  if [ "$1" = '' ]; then
    git recent | head -n 30 | cat -n
  else
    local INDEX=$1
    [ $INDEX = '-' ] && INDEX=1
    git checkout $(git recent | awk -v n=$INDEX '{ if (NR == n) print $0 }')
  fi
}

branchname(){
  git branch | grep \* | awk '{print $2}'
}

featuretitle(){
  echo ${$(branchname)//_/ } | ruby -e 'puts "#{STDIN.gets.capitalize.chomp}:"'
}

# Git commit w/ message
# Everything after gcm will be used as the commit messge
# If not on master message will be prefixed with feature title
gcm(){
  if [ $(branchname) = 'master' ]; then
    git commit -m "$(echo $@)"
  else
    git commit -m "$(featuretitle) $(echo -n $@)"
  fi
}

# Make it easy to change just the name.
# Usage ren some/path/file.rb new_name.rb => some/path/new_name.rb
ren(){ mv $1 `dirname $1`/$2 }
# :todo: Make it smart to check for a specfied path or extension. Only use default if nothing provided. move to current would be ./

g(){
  if [ "$1" = '' ]; then
    git status -s
  else
    git $@
  fi
}

js() {
  local color=true
  while getopts ":n" opt; do
    case $opt in
      n)
        color=false
        ;;
    esac
  done
  if [ $color = true ]; then
    json | jscolor
  else
    json
  fi
}

# Generate spec for model
#
# Example:
#
#   $ model_spec app/model/user.rb
#
model_spec() {
  rails generate model $(basename -s ".rb" $1) -s --migration=false
}
