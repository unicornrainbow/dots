# Setup Path
export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:.:~/bin

# Include gem directory in path and setup RVM. Also add current directory to path.
export PATH=`gem env gemdir`:$PATH

[[ -s "/Users/btaylor/.rvm/scripts/rvm" ]] && source "/Users/btaylor/.rvm/scripts/rvm"  # This loads RVM into a shell session.

export NODE_PATH=/usr/local/lib/node
