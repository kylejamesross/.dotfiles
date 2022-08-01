# install nix
curl -L https://nixos.org/nix/install | sh

# grant permissions
chmod +x ~/.nix-profile/etc/profile.d/nix.sh

#source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install packages
nix-env -iA \
	nixpkgs.python3 \
    nixpkgs.curl \

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user

python3 -m pip install --user ansible

PATH="$PATH:${HOME}/.local/bin"
