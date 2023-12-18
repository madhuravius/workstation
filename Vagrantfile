# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.ssh.username = 'madhu' if ARGV[0] == 'ssh'
  config.ssh.forward_agent = true

  config.vm.box = 'debian/bookworm64'
  config.vm.box_check_update = true
  config.vm.hostname = 'workstation'
  config.vm.define 'workstation'
  config.vm.provider 'virtualbox' do |d|
    d.name = 'workstation'
    d.memory = '3072'
  end

  config.vm.provision :docker

  config.vm.provision :shell, path: 'vagrant/bootstrap.sh'
end
