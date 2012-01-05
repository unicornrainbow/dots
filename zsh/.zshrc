# This should be set to the location of this file.
pushd dotfiles/zsh > /dev/null

source env.sh
source config.sh
source aliases.sh

# Take notes in terminal
source journal.sh

popd > /dev/null
