# -*- mode: ruby -*-
# vi: set ft=ruby :
# frozen_string_literal: true

Vagrant.configure('2') do |config|
  adapter_name = ENV['VAGRANT_ETHERNET_ADAPTER']

  config.vm.provider 'virtualbox' do |vb|
    vb.name = 'vcntlm'
    vb.memory = '512'
    vb.cpus = '1'
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
  end
  config.vm.box = 'mariolavoro85/ubuntu-18.04-cntlm'
  config.vm.network 'private_network', ip: '192.168.56.101', name: adapter_name
  config.vm.network 'forwarded_port', protocol: 'tcp', guest: 3128, host: 3128
  config.vm.provision 'shell' do |s|
    s.args = [
      "--user=#{ENV['VAGRANT_CNTLM_USERNAME']}",
      "--password=#{ENV['VAGRANT_CNTLM_PASSWORD']}",
      "--proxy=#{ENV['VAGRANT_CNTLM_PROXY']}",
      "--no-proxy=#{ENV['VAGRANT_CNTLM_NO_PROXY']}",
      '--domain=Vagrant',
      '--listen=0.0.0.0:3128'
    ]
    s.path = 'provision.sh'
    s.privileged = false
  end
end
