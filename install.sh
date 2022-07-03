# install nix
curl -L https://nixos.org/nix/install | sh

#source nix
~/.nix-profile/etc/profile.d/nix.sh

# install packages
nix-env -iA \
	nixpkgs.oh-my-zsh \
	nixpkgs.tmux \
	nixpkgs.stow \
	nixpkgs.bat \

# stow dotfiles
stow git
stow zsh


# zsh config
command -v zsh | sudo tee -a /etc/shells

sudo chsh -s $(which zsh) $USER
