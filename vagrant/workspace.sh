#!/usr/bin/env bash

# Set up user workspace so everything is present to work.

echo "Running as: $USER"

git config --global user.name "Madhusudan Ravi"
git config --global user.email "madhuravius@protonmail.com"
git config --global init.defaultBranch "main"


chsh -s $(which fish)
# set up autocomplete
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf install z

sudo echo "elevating permissions to install nix"
sh <(curl -L https://nixos.org/nix/install) --no-daemon

git clone https://github.com/madhuravius/nvim.git ~/.config/nvim || true

echo "cacert=/etc/ssl/certs/ca-certificates.crt" >> ~/.curlrc

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
mkdir -p ~/.config/fish/completions
ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions

curl https://sh.rustup.rs -sSf | sh -s -- -y

source ~/.asdf/asdf.sh
asdf plugin add bun
asdf plugin add crystal
asdf plugin add elixir
asdf plugin add erlang
asdf plugin add golang
asdf plugin add java
asdf plugin add nodejs
asdf plugin add ruby
asdf plugin add python
asdf plugin add terraform

# absolutely necessary for editor deps
asdf install golang 1.21.5
asdf global golang 1.21.5

asdf install nodejs 20.10.0
asdf global nodejs 20.10.0

asdf install python 3.11.6
asdf global python 3.11.6

asdf install ruby 3.1.3
asdf global ruby 3.1.3

asdf reshim

pip install -r /vagrant/vagrant/requirements.txt

asdf reshim

cp /vagrant/vagrant/fish.config ~/.config/fish/config.fish
