#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive

apt-get update 
apt-get install -y \
	btop \
	build-essential \
	ca-certificates \
	curl \
	fish \
	fuse \
	libssl-dev \
	neofetch \
	python3-pip \
	git \
	sudo \
	wget \
	zip

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
mv nvim.appimage /usr/local/bin/nvim
chmod +x /usr/local/bin/nvim

useradd -m -s /bin/bash -U madhu -u 666
usermod -aG docker madhu
passwd -d madhu
cp -pr /home/vagrant/.ssh /home/madhu/
chown -R madhu:madhu /home/madhu
echo "%madhu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/madhu

mkdir /usr/local/share/ca-certificates/self-signed
cp /vagrant/certificates/root.crt /usr/local/share/ca-certificates/self-signed/root.crt
update-ca-certificates

/bin/su -s /bin/bash -c '/vagrant/vagrant/workspace.sh' madhu
