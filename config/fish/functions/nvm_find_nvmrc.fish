function nvm_find_nvmrc
  set target (realpath $argv[1])
  set filename "$target/.nvmrc"

  if test -e $filename
    echo $filename
  else
    echo ""
  end
end
