function use_nvmrc
  set node_version (nvm version)
  set nvmrc_path (nvm_find_nvmrc $argv[1])

  if test -n "$nvmrc_path"
    set version (cat $nvmrc_path)
    set nvmrc_code_version (nvm version $version)

    if test "$nvmrc_code_version" = "N/A"
      nvm install $version
    else if test "$nvmrc_code_version" != "$node_version"
      nvm use $nvmrc_code_version
    end
  else if test "$node_version" != (nvm version default)
    echo "Reverting to nvm default version"
    nvm use default
  end
end
