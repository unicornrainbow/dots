# Setup Path
export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:.

# Include gem directory in path and setup RVM. Also add current directory to path.
export PATH=`gem env gemdir`:$PATH
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
