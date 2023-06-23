
#
# Shell
#

{ pkgs, ... }:

{
  programs = {
    tmux = {
      enable = true;
      keyMode = "vi";
      historyLimit = 100000;
      plugins = [ 
        pkgs.tmuxPlugins.dracula
        pkgs.tmuxPlugins.yank 
      ];
      extraConfig = ''
        set -s escape-time 100
        setw -g mouse on
        set-option -g focus-events on
        set-option -sa terminal-overrides ",alacritty:RGB"

        bind-key -r f run-shell "tmux neww ~/.dotfiles/bin/tmux-sessionizer"
        bind-key -r h run-shell "tmux neww ~/.dotfiles/bin/cht"
        bind-key -r v run-shell "tmux neww -S -n lazygit lazygit"
        bind-key -r , run-shell "tmux neww -S -n joplin joplin"
        bind-key -r . run-shell "tmux neww -S -n bpytop bpytop"
        bind-key -r R run-shell "tmux source ~/.tmux.conf"
        bind-key -r / run-shell "tmux neww -S -n playground"
        bind-key -r t run-shell "tmux neww -S -n terminal"
        bind-key -r e run-shell "tmux neww -S -n nvim nvim"
        bind-key -r l run-shell "tmux neww -S -n lf lf"
        bind-key -r - run-shell "tmux neww -S -n tig tig"

        set -g default-terminal "screen-256color"
        set -ga terminal-overrides ",xterm-256color:Tc"

        set -g @dracula-show-left-icon 
        set -g @dracula-plugins "cpu-usage ram-usage weather time"
        set -g @dracula-show-powerline true
        set -g @dracula-show-fahrenheit false
        set -g @dracula-military-time false
        set -g @dracula-cpu-usage-colors "pink dark_gray"
        set -g @dracula-ram-usage-colors "green dark_gray"
        '';
    };
  };
}
