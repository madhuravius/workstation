#!/usr/bin/env bash

# Set up user workspace so everything is present to work.

echo "Running as: $USER"

git config --global user.name "Madhusudan Ravi"
git config --global user.email "madhuravius@protonmail.com"
git config --global init.defaultBranch "main"


chsh -s $(which fish)
# set up autocomplete
cd /home/$USER
curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install_omf && chmod +x ./install_omf
fish install_omf --noninteractive
fish -c "omf install z"

git clone https://github.com/madhuravius/nvim.git ~/.config/nvim || true

echo "cacert=/etc/ssl/certs/ca-certificates.crt" >> ~/.curlrc

wget https://github.com/asdf-vm/asdf/releases/download/v0.16.7/asdf-v0.16.7-linux-amd64.tar.gz
tar -xvf ./asdf-v0.16.7-linux-amd64.tar.gz
sudo mv asdf /usr/local/bin/

mkdir -p ~/.config/fish/completions

curl https://sh.rustup.rs -sSf | sh -s -- -y

asdf plugin add bun
asdf plugin add crystal
asdf plugin add elixir
asdf plugin add erlang
asdf plugin add golang
asdf plugin add gradle
asdf plugin add java
asdf plugin add maven
asdf plugin add nodejs
asdf plugin add nomad
asdf plugin add ruby
asdf plugin add python
asdf plugin add terraform

# absolutely necessary for editor deps
asdf install bun latest
asdf set --home bun latest

asdf install golang 1.24.0
asdf set --home golang 1.24.0

asdf install java openjdk-21.0.1
asdf set --home java openjdk-21.0.1

asdf install nodejs 22.14.0
asdf set --home nodejs 22.14.0

asdf install python 3.13.2
asdf set --home python 3.13.2

asdf install ruby 3.3.5
asdf set --home ruby 3.3.5

asdf install maven 3.9.6
asdf set --home maven 3.9.6

asdf install nomad latest
asdf set --home nomad latest

asdf reshim

pip install -r /vagrant/vagrant/requirements.txt

asdf reshim

cp /vagrant/vagrant/fish.config ~/.config/fish/config.fish

nvim --headless "+Lazy! sync" +qa
