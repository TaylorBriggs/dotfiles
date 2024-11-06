function nvim_stash -d "Stash current nvim config to experiment with changes"
  mkdir ~/.config/xnvim
  mv ~/.config/nvim ~/.config/xnvim
  mkdir ~/.config/nvim
end
