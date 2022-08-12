if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ${HOME}/.zsh_plugins.sh

# Bundle zsh plugins via antibody
alias update-antibody='antibody bundle < $HOME/.zsh_plugins.txt > $HOME/.zsh_plugins.sh'

alias list-npm-globals='npm list -g --depth=0'

alias ls='ls -alh --color'
alias pb='git branch --merged | grep -v -E "main|master|staging|dev|$(git rev-parse --abbrev-ref HEAD)" > /tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'
alias vim='nvim'

export BAT_THEME="gruvbox-dark"

# nix
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -e /home/kyler/.nix-profile/etc/profile.d/nix.sh ]; then . /home/kyler/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

if [ -e /home/kyle/.nix-profile/etc/profile.d/nix.sh ]; then . /home/kyle/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# PATH
PATH="$PATH:${HOME}/.local/bin"
PATH="$PATH:${HOME}/.dotfiles/bin"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
