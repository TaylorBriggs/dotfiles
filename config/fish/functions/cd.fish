function cd --wraps cd
  use_nvmrc $argv
  builtin cd $argv
end
