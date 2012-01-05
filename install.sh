DOT_FILES=$(cd $(dirname $0); pwd -P)

for filename in $DOT_FILES/*/.*; do
  if [ -f $filename ]; then
    echo "linking $filename"
    ln -f "$filename" ~
  fi
done
