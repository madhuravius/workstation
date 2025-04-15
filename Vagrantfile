# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

IS_SSH = ARGV[0] = 'ssh'
WORK_PATH = "#{Dir.home}/work/".freeze

def configure_vm_networking(config)
  config.vm.define :workstation
  config.vm.hostname = 'workstation'
  (9000..9100).each do |i|
    config.vm.network :forwarded_port, guest: i, host: i, host_ip: '0.0.0.0'
  end
end

def configure_vm(config)
  config.vm.box = 'ubuntu/jammy64'
  configure_vm_networking config

  config.vm.boot_timeout = 600
  config.vm.provider 'virtualbox' do |d|
    d.name = 'workstation'
    d.memory = '6144'
    d.cpus = 4
  end

  config.vm.provision :docker
  config.vm.provision :shell, path: 'vagrant/bootstrap.sh'
end

def configure_disk(config)
  # if resizing, will want to do the following after: vagrant halt && vagrant up
  # 1. use this to resize partition with free space:
  #   sudo cfdisk /dev/sda
  # 2. use this to resize fs and verify with df after:
  #   sudo resize2fs -p -F /dev/sda1
  config.disksize.size = ENV['DISK_SIZE'] || '40GB'

  # only allow the following configurations to hit after the initial boot
  return unless File.exist?('.vagrant/machines/workstation/virtualbox/id')

  # only mount this if path exists and only when ssh'ing, otherwise not needed
  user = ENV['USER_IN_BOX'] || 'madhu'
  group = ENV['GROUP_IN_BOX'] || 'madhu'
  config.ssh.username = user

  return unless Dir.exist?(WORK_PATH)

  config.vm.synced_folder WORK_PATH,
                          '/home/madhu/work/',
                          owner: user, group: group, disabled: !IS_SSH
end

Vagrant.configure('2') do |config|
  config.env.enable
  config.ssh.forward_agent = true
  config.timezone.value = 'UTC' if Vagrant.has_plugin?('vagrant-timezone')

  configure_vm config
  configure_disk config
end
