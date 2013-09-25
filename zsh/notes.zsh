#! /usr/bin/env zsh

export NOTES_ROOT=~/Dropbox/Notes
export NOTEBOOKS_ROOT=~/Dropbox/Notebooks

notes(){
  [ "$1" = '' ] && echo "Usage: notes [new|ls]" && return
  eval "notes-$1 $2 $3 $4 $5 $6 $7"
}
alias note=notes

# Create a new note.
notes-new(){
  if [ "$1" != '' ]; then
    local DIR="$NOTEBOOKS_ROOT/$1/$(date +%Y)/$(date +%m)/$(date +%d)"
  else
    local DIR="$NOTES_ROOT/$(date +%Y)/$(date +%m)/$(date +%d)"
  fi
  mkdir -p $DIR
  eval $EDITOR "$DIR/$(date +%T).txt"
}

notes-last(){
  if [ "$1" != '' ]; then
    local DIR="$NOTEBOOKS_ROOT/$1/$(date +%Y)/$(date +%m)/$(date +%d)"
  else
    local DIR="$NOTES_ROOT/$(date +%Y)/$(date +%m)/$(date +%d)"
  fi
  eval $EDITOR $DIR/$(ls -t $DIR | head -n 1)
}

# Review Notes
notes-ls(){
  # Display notes reverse cronigically
  if [ "$1" != '' ]; then
    local OUTPUT=$(mktemp -t notes)
    local DIR="$NOTEBOOKS_ROOT/$1"
  else
    local OUTPUT=$(mktemp -t notebooks)
    local DIR="$NOTES_ROOT"
  fi

  for file in $(find $DIR -type f | sort -r | head -n 30); do
    echo "\n=== $file ===\n" >> $OUTPUT
    cat $file >> $OUTPUT
    echo "\n" >> $OUTPUT
  done
  cat $OUTPUT | less
  rm $OUTPUT
}


notes-done(){
  notes-ls | grep "@done($(date "+%Y-%m-$1")"
}

notes-grep(){
  grep -R $1 -C 10 $NOTES_ROOT
}
