function nvim_unstash
	if test -d $HOME/dotfiles/config/xnvim
    rm -rf $HOME/dotfiles/config/nvim
    mv $HOME/dotfiles/config/xnvim $HOME/dotfiles/config/nvim
  end
end
