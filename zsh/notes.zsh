#! /usr/bin/env zsh

export NOTES_ROOT=~/Dropbox/Notes

notes(){
  [ "$1" = '' ] && echo "Usage: notes [new|ls]" && return
  eval "notes-$1"
}
alias note=notes

# Create a new note.
notes-new(){
  local DIR="$NOTES_ROOT/$(date +%Y)/$(date +%m)/$(date +%d)"
  mkdir -p $DIR
  $EDITOR "$DIR/$(date +%T).txt"
}

notes-last(){
  local DIR="$NOTES_ROOT/$(date +%Y)/$(date +%m)/$(date +%d)"
  $EDITOR $DIR/$(ls -t $DIR | head -n 1)
}

# Review Notes
notes-ls(){
  # Display notes reverse cronigically
  local OUTPUT=$(mktemp -t notes)
  for file in $(find $NOTES_ROOT -type f | sort -r); do
    echo "\n=== $file ===\n" >> $OUTPUT
    cat $file >> $OUTPUT
    echo "\n" >> $OUTPUT
  done
  cat $OUTPUT | less
  rm $OUTPUT
}



