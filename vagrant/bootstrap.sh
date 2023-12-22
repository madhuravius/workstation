#!/usr/bin/env bash

# Set up the root account with base deps on the machine for reuse.

DEBIAN_FRONTEND=noninteractive
ZELLIJ_VERSION=0.39.2

apt-get update 
apt-get install -y \
	bat \
	btop \
	build-essential \
	ca-certificates \
	curl \
	fzf \
	fish \
	fuse \
	git \
	libbz2-dev \
	liblzma-dev \
	libncurses5-dev \
	libncursesw5-dev \
	libreadline-dev \
	libssl-dev \
	libffi-dev \
	libsqlite3-dev \
	llvm \
	neofetch \
	python3-pip \
	ripgrep \
	sudo \
	wget \
	zip \
	zlib1g-dev

# install nvim, must be nightly
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
mv nvim.appimage /usr/local/bin/nvim
chmod +x /usr/local/bin/nvim

# install zellij
wget https://github.com/zellij-org/zellij/releases/download/v$ZELLIJ_VERSION/zellij-x86_64-unknown-linux-musl.tar.gz
tar -xvf ./zellij-x86_64-unknown-linux-musl.tar.gz
mv ./zellij /usr/local/bin/zellij

useradd -m -s /bin/bash -U madhu -u 666
usermod -aG docker madhu
passwd -d madhu
cp -pr /home/vagrant/.ssh /home/madhu/
chown -R madhu:madhu /home/madhu
echo "%madhu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/madhu

mkdir /usr/local/share/ca-certificates/self-signed
cp /vagrant/certificates/root.crt /usr/local/share/ca-certificates/self-signed/root.crt
update-ca-certificates

/vagrant/vagrant/setup-swap.sh

/bin/su -s /bin/bash -c '/vagrant/vagrant/workspace.sh' madhu
