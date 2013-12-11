#! /usr/bin/env zsh

export NOTES_ROOT=~/.notes

notes(){
  [ "$1" = '' ] && echo "Usage: notes [new|ls]" && return
  eval "notes-$1 $2 $3 $4 $5 $6 $7"
}
alias note=notes

# Create a new note.
notes-new(){
  local date_path="$(date +%Y)/$(date +%m)/$(date +%d)"

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
    local DIR="$TOPICS_DIR/entries/$date_path"
  else
    local DIR="$NOTES_ROOT/entries/$date_path"
  fi
  mkdir -p $DIR
  local file_name="$(date +%T).txt"
  eval $EDITOR "$DIR/$file_name"

  # If there are changes, commit them to the notes git repo.
  pushd $NOTES_ROOT
  git add -A > /dev/null
  git commit -m "Create $date_path/$file_name" > /dev/null
  popd
}

notes-last(){
  local date_path="$(date +%Y)/$(date +%m)/$(date +%d)"
  if [ "$1" != '' ]; then
    local DIR="$NOTES_ROOT/$1/entries/$date_path"
  else
    local DIR="$NOTES_ROOT/entries/$date_path"
  fi

  local file_path=$DIR/$(ls -t $DIR | head -n 1)
  eval $EDITOR $file_path

  # If there are changes, commit them to the notes git repo.
  pushd $NOTES_ROOT
  local file_name=$(basename $file_path)
  git add -A > /dev/null
  git commit -m "Edit $date_path/$file_name" > /dev/null
  popd
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
