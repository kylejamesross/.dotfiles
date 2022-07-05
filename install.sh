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
	nixpkgs.stow \
	nixpkgs.bat \

# stow dotfiles
stow git
stow zsh
stow vim


# zsh config
command -v zsh | sudo tee -a /etc/shells

sudo chsh -s $(which zsh) $USER

# bundle zsh plugins 
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

