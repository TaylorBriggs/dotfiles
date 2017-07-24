#!/bin/sh

cutstring="DO NOT EDIT BELOW THIS LINE"

for dir in */; do
  target="$HOME/.$dir"

  if [ -e $target ]; then
    for name in $dir*; do
      inner_target="$target${name#$dir}"

      if [ ! -e "$inner_target" ]; then
        echo "Creating $inner_target"

        if [ -d $name ]; then
          cp -Rn "$PWD/$name" "$inner_target"
        else
          ln -s "$PWD/$name" "$inner_target"
        fi
      fi
    done
  else
    echo "Creating $target"

    cp -Rn "$PWD/$dir" "$target"
  fi
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
            ln -s "$PWD/$name" "$target"
          fi
        fi
      fi
  fi
done
