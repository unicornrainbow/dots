#! /usr/bin/env zsh

export NOTES_ROOT=~/.notes

notes(){
  [ "$1" = '' ] && echo "Usage: notes [new|ls]" && return
  eval "notes-$1 $2 $3 $4 $5 $6 $7"
}
alias note=notes

# Create a new note.
notes-new(){
  if [ "$1" != '' ]; then
    local TOPICS_DIR="$NOTES_ROOT/$1"
    # Prompt or abort if the topic directory doesn't exist.
    if [ ! -d $TOPICS_DIR ]; then
      echo "Do you wish to create topic $1?"
      select yn in "Yes" "No"; do
          case $yn in
              Yes ) break;;
              No ) return;;
          esac
      done
    fi
    local DIR="$TOPICS_DIR/entries/$(date +%Y)/$(date +%m)/$(date +%d)"
  else
    local DIR="$NOTES_ROOT/entries/$(date +%Y)/$(date +%m)/$(date +%d)"
  fi
  mkdir -p $DIR
  eval $EDITOR "$DIR/$(date +%T).txt"
}

notes-last(){
  if [ "$1" != '' ]; then
    local DIR="$NOTES_ROOT/$1/entries/$(date +%Y)/$(date +%m)/$(date +%d)"
  else
    local DIR="$NOTES_ROOT/entries/$(date +%Y)/$(date +%m)/$(date +%d)"
  fi
  eval $EDITOR $DIR/$(ls -t $DIR | head -n 1)
}

# Review Notes
notes-ls(){
  # Display notes reverse cronigically
  if [ "$1" != '' ]; then
    local OUTPUT=$(mktemp -t notes)
    local DIR="$NOTES_ROOT/$1/entries"
  else
    local OUTPUT=$(mktemp -t notebooks)
    local DIR="$NOTES_ROOT/entries"
  fi

  for file in $(find $DIR -type f | sort -r | head -n 30); do
    echo "\n=== $file ===\n" >> $OUTPUT
    cat $file >> $OUTPUT
    echo "\n" >> $OUTPUT
  done
  cat $OUTPUT | less
  rm $OUTPUT
}

notes-topics() {
  if [ "$1" != '' ]; then
    local DIR="$NOTES_ROOT/$1"
  else
    local DIR="$NOTES_ROOT"
  fi

  # All directories are topics except for the entires directory.
  ls $DIR -1 | grep -v entries
}

notes-done(){
  notes-ls | grep "@done($(date "+%Y-%m-$1")"
}

notes-grep(){
  grep -R $1 -C 10 $NOTES_ROOT
}
