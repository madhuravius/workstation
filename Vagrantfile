# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

IS_SSH = ARGV[0] = 'ssh'
WORK_PATH = "#{Dir.home}/work/".freeze

Vagrant.configure('2') do |config|
  config.timezone.value = 'UTC' if Vagrant.has_plugin?('vagrant-timezone')
  config.ssh.forward_agent = true

  # if resizing, will want to do the following after: vagrant halt && vagrant up
  # 1. use this to resize partition with free space:
  #   sudo cfdisk /dev/sda
  # 2. use this to resize fs and verify with df after:
  #   sudo resize2fs -p -F /dev/sda1
  config.disksize.size = '40GB'

  config.vm.box = 'debian/bookworm64'
  config.vm.define :workstation
  config.vm.hostname = 'workstation'
  (9000..9100).each do |i|
    config.vm.network :forwarded_port, guest: i, host: i, host_ip: '127.0.0.1'
  end

  config.vm.boot_timeout = 60
  config.vm.provider 'virtualbox' do |d|
    d.name = 'workstation'
    d.memory = '4096'
  end

  config.vm.provision :docker
  config.vm.provision :shell, path: 'vagrant/bootstrap.sh'

  # only allow the following configurations to hit after the initial boot
  if File.exist?('.vagrant/machines/workstation/virtualbox/id')
    # only mount this if path exists and only when ssh'ing, otherwise not needed
    config.ssh.username = 'madhu'
    if Dir.exist?(WORK_PATH)
      config.vm.synced_folder WORK_PATH,
                              '/home/madhu/work/',
                              owner: 'madhu', group: 'madhu', disabled: !IS_SSH
    end
  end
end
