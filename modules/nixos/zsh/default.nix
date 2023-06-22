#
# Shell
#

{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;            # Auto suggest options and highlights syntax, searches in history for options
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 100000;

      ohMyZsh = {                               # Extra plugins for zsh
        enable = true;
        plugins = [ "git" ];
      };

      shellInit = ''                            # Zsh theme
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

alias ls='exa -labg --git --color auto'
alias cat='bat'
alias pb='git branch --merged | grep -v -E "main|master|staging|dev|$(git rev-parse --abbrev-ref HEAD)" > /tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'
alias vim='nvim'
alias v='nvim'
alias docker="sudo docker"
alias docker-compose="sudo docker-compose"
alias fonts="fc-list"
alias gp="git push origin HEAD 2>&1 | grep -o 'http[s]\?://[^\"]\+' | xargs git web--browse"

export EDITOR="nvim"
export OPENER="xdg-open"
export BAT_THEME="Dracula"


if [ -f "$HOME/.dotfiles/zsh/feed-access-token" ]; then
  export FEED_ACCESSTOKEN=$(cat $HOME/.dotfiles/zsh/feed-access-token)
  export ENV DOTNET_SYSTEM_NET_HTTP_USESOCKETSHTTPHANDLER=0
  export VSS_NUGET_EXTERNAL_FEED_ENDPOINTS="{\"endpointCredentials\": [{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/NuAgile/_packaging/NudeSolutions/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.dotfiles/zsh/feed-access-token)\"},{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/ProjectVicious/_packaging/NudeGet/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.dotfiles/zsh/feed-access-token)\"}]}"
fi

# PATH
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.dotfiles/bin"
PATH="$PATH:/usr/share/dotnet"
PATH="$PATH:$HOME/.dotnet/tools"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
autoload -Uz compinit && compinit
      '';
    };
  };
}
