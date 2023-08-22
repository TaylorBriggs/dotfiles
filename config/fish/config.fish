# this loads homebrew variables
/opt/homebrew/bin/brew shellenv | source
# rtx
rtx activate fish | source
# other configs
source $HOME/.config/fish/config/gpg.fish
source $HOME/.config/fish/config/github.fish
source $HOME/.config/fish/config/ruby.fish
source $HOME/.config/fish/config/editor.fish
