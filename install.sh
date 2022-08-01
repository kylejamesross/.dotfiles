#!/usr/bin/env bash

# install nix
curl -L https://nixos.org/nix/install | sh

# grant permissions
chmod +x ~/.nix-profile/etc/profile.d/nix.sh

#source nix
. ~/.nix-profile/etc/profile.d/nix.sh


# install packages
nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.antibody \
	nixpkgs.tmux \
    nixpkgs.neovim
	nixpkgs.stow \
	nixpkgs.bat \

# download vim plugins
git clone https://github.com/dracula/vim.git ./vim/.vim/pack/themes/opt/dracula
git clone https://github.com/tpope/vim-fugitive.git ./vim/.vim/pack/git/start/fugitive 
git clone https://github.com/ctrlpvim/ctrlp.vim.git ./vim/.vim/pack/general/start/ctrlp
git clone https://github.com/easymotion/vim-easymotion.git ./vim/.vim/pack/general/start/vim-easymotion

# download nvim plugins
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# stow dotfiles
stow git
stow zsh
stow vim
stow nvim 


# zsh config
command -v zsh | sudo tee -a /etc/shells

sudo chsh -s $(which zsh) $USER

# install nvim plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# bundle zsh plugins 
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

