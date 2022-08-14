# .dotfiles

## Install git
`sudo apt update`

`sudo apt install git`

## Clone Repo
`git -C ~ clone https://github.com/kylejamesross/.dotfiles`

## Install anisble
`sudo apt install software-properties-common`

`sudo add-apt-repository --yes --update ppa:ansible/ansible`

`sudo apt install ansible`

## Running ansible
`ansible-playbook ~/.dotfiles/install.yml --ask-become-pass --ask-vault-pass`
