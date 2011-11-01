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

eval "$(rbenv init -)"

export NODE_PATH=/usr/local/lib/node
