#!/bin/sh

cutstring="DO NOT EDIT BELOW THIS LINE"

linkFile() {
  ln -s "$1" "$2"
}

walkFolderAndLinkContents () {
  maybe_folder=$1

  for file in $maybe_folder*; do
    if [ -f $file ]; then
      filename=${file#$maybe_folder}
      dest="$HOME/.$maybe_folder"

      if [ -e "$dest$filename" ]; then
        echo "$dest$filename already exists!"
      else
        echo "Creating $dest$filename..."
        linkFile "$PWD/$file" "$dest"
      fi
    elif [ -d $file ]; then
      walkFolderAndLinkContents $file/
    else
      echo "Nothing to see here..."
    fi
  done
}

for dir in */; do
  walkFolderAndLinkContents $dir
done

for name in *; do
  target="$HOME/.$name"

  if [ -f $name ]; then
    if [[ $name != 'install.sh' ]]; then
      if [ -e $target ]; then
        if [ ! -L $target ]; then
          cutline=`grep -n -m1 "$cutstring" "$target" | sed "s/:.*//"`

          if [[ -n $cutline ]]; then
            let "cutline = $cutline - 1"
            echo "Updating $target"
            head -n $cutline "$target" > update_tmp
            startline=`tail -r "$name" | grep -n -m1 "$cutstring" | sed "s/:.*//"`
            if [[ -n $startline ]]; then
              tail -n $startline "$name" >> update_tmp
            else
              cat "$name" >> update_tmp
            fi
            mv update_tmp "$target"
          else
            echo "WARNING: $target exists but is not a symlink."
          fi
        fi
      else
        echo "Creating $target"
        if [[ -n `grep "$cutstring" "$name"` ]]; then
          cp "$PWD/$name" "$target"
        else
          linkFile "$PWD/$name" "$target"
        fi
      fi
    fi
  fi
done
