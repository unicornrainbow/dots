# Move to the dotfile directory.
pushd $(cd $(dirname $0); pwd -P) > /dev/null
# echo $(files */.*) # ~/

for filename in */.*; do
  if [ -f $filename ]; then
    echo "linking $filename"
    ln -f "$filename" ~
  fi
done

