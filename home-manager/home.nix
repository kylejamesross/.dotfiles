# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
# You can import other home-manager modules here
  imports = [
# If you want to use modules your own flake exports (from modules/home-manager):
# outputs.homeManagerModules.example

# Or modules exported from other flakes (such as nix-colors):
# inputs.nix-colors.homeManagerModules.default

# You can also split up your configuration and import pieces of it here:
# ./nvim.nix
  ];

  nixpkgs = {
# You can add overlays here
    overlays = [
# Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
	outputs.overlays.modifications
	outputs.overlays.unstable-packages

# You can also add overlays exported from other flakes:
# neovim-nightly-overlay.overlays.default

# Or define it inline, for example:
# (final: prev: {
#   hi = final.hello.overrideAttrs (oldAttrs: {
#     patches = [ ./change-hello-to-hi.patch ];
#   });
# })
    ];
# Configure your nixpkgs instance
    config = {
# Disable if you don't want unfree packages
      allowUnfree = true;
# Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "kyle";
    homeDirectory = "/home/kyle";
    pointerCursor = {                        
      gtk.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 20;
    };
  };

  home.packages = with pkgs; [	
    neovim
    git
    btop 
    brave
    vlc
    okular
    unzip
    unrar
    zip
    kitty
    pamixer
    playerctl
    xfce.thunar
    xfce.thunar-archive-plugin
    gnome.file-roller
    lf
    curl
    lazygit
    tig
    networkmanagerapplet
    ripgrep
    fd
    exa
    du-dust
    nodejs_18
    gcc
    wofi
    neofetch
    stow
    fzf
    vlc
    gimp
    libreoffice-still
    tldr
    joplin
    firefox
    nodePackages.typescript
    stow
    ];

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrains Mono Medium";
    };                                        # Cursor is declared under home.pointerCursor
  };

# Enable home-manager and git
  programs.home-manager.enable = true;
#programs.git.enable = true;
# Nicely reload system units when changing configs systemd.user.startServices = "sd-switch";

# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";					     
}
