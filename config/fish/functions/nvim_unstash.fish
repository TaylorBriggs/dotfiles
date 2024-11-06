function nvim_unstash -d "Restore previously stashed nvim config"
	if test -d ~/.config/xnvim
    if test -d ~/.config/nvim
      rm -rf ~/.config/nvim
    end
    mv ~/.config/xnvim ~/.config/nvim
    rm -rf ~/.config/xnvim
  end
end
