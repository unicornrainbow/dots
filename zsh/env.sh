# Include gem directory in path and setup RVM. Also add current directory to path.
export PATH=`gem env gemdir`:$PATH:.
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
