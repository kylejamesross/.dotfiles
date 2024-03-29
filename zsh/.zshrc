source ~/.zsh_plugins.sh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


alias list-npm-globals='npm list -g --depth=0'

alias ls='exa -labg --git --color auto'
alias cat='bat'
alias pb='git branch --merged | grep -v -E "main|master|staging|dev|$(git rev-parse --abbrev-ref HEAD)" > /tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'
alias vim='nvim'
alias v='nvim'
alias nuget="mono /usr/local/bin/nuget.exe"
alias docker="sudo docker"
alias docker-compose="sudo docker-compose"
alias timeshift="sudo timeshift-gtk"
alias fonts="fc-list"
alias st="python3 ${HOME}/.dotfiles/bin/speedtest.py"
alias update="yay -Syu"
alias buildantibody="antibody bundle < /home/kyle/.zsh_plugins.txt > /home/kyle/.zsh_plugins.sh"
alias gp="git push origin HEAD 2>&1 | grep -o 'http[s]\?://[^\"]\+' | xargs git web--browse"

export DIR_NVIM_OPTIONS="${HOME}/.dotfiles/nvim/.config/nvim/lua/user"
export DIR_DOTFILES="${HOME}/.dotfiles"
export EDITOR="nvim"
export OPENER="xdg-open"
export BAT_THEME="Dracula"


if [ -f "$HOME/.dotfiles/zsh/feed-access-token" ]; then
  export FEED_ACCESSTOKEN=$(cat $HOME/.dotfiles/zsh/feed-access-token)
  export ENV DOTNET_SYSTEM_NET_HTTP_USESOCKETSHTTPHANDLER=0
  export VSS_NUGET_EXTERNAL_FEED_ENDPOINTS="{\"endpointCredentials\": [{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/NuAgile/_packaging/NudeSolutions/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.dotfiles/zsh/feed-access-token)\"},{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/ProjectVicious/_packaging/NudeGet/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.dotfiles/zsh/feed-access-token)\"}]}"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# PATH
PATH="$PATH:${HOME}/.local/bin"
PATH="$PATH:${HOME}/.dotfiles/bin"
PATH="$PATH:/usr/share/dotnet"
PATH="$PATH:${HOME}/.dotnet/tools"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
autoload -Uz compinit && compinit

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
