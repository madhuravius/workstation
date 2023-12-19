# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

IS_SSH = ARGV[0] = 'ssh'
WORK_PATH = "#{Dir.home}/work/".freeze

Vagrant.configure('2') do |config|
  config.ssh.username = 'madhu' if IS_SSH
  config.ssh.forward_agent = true

  config.vm.box = 'debian/bookworm64'
  config.vm.box_check_update = true
  config.vm.hostname = 'workstation'
  config.vm.define 'workstation'
  config.vm.provider 'virtualbox' do |d|
    d.name = 'workstation'
    d.memory = '4096'
  end

  config.vm.provision :docker
  config.vm.provision :shell, path: 'vagrant/bootstrap.sh'

  # only mount this if path exists
  if Dir.exist?(WORK_PATH)
    config.vm.synced_folder WORK_PATH,
                            '/home/madhu/work/',
                            owner: 'madhu', group: 'madhu', disabled: !IS_SSH
  end
end
