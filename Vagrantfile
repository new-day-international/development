# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_plugin 'vagrant-berkshelf'
Vagrant.require_plugin 'vagrant-omnibus'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  defaults = {
    java: {
      oracle: {
        'accept_oracle_download_terms' => true
      }
    },
    lightnet: {
      domain_name: 'localdev.lightnetb.org',
      create_user: false,
      application_directory: '/vagrant',
      user: 'vagrant',
      group: 'vagrant',
    },
    postgresql: {
      password: {
        postgres: 'password',
      }
    },
  }
  settings = YAML.load_file(File.expand_path('../settings.yml', __FILE__)).deep_symbolize_keys!
  settings = defaults.deep_merge!(settings)

  config.omnibus.chef_version = '10.26.0'
  config.vm.hostname = 'localdev'
  config.vm.box = 'precise64'
  config.vm.box_url = 'http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box'
  config.vm.network :private_network, ip: '172.16.42.42'
  config.berkshelf.enabled = true

  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ['modifyvm', :id, '--memory', '3072']
  end

  if settings.key?(:aws)
    config.vm.provider :aws do |aws, override|
      settings[:aws].each_key do |key|
        next if [:default_username, :private_key_path].include?(key)
        aws.send(:"#{key.to_s}=", settings[:aws][key])
      end
      override.ssh.username = settings[:aws][:default_username]
      override.ssh.private_key_path = settings[:aws][:private_key_path]
    end
    defaults[:lightnet][:user] = settings[:aws][:default_username]
    defaults[:lightnet][:group] = settings[:aws][:default_username]
  end

  config.vm.provision :chef_solo do |chef|
    chef.json = settings

    chef.run_list = [
      'recipe[lightnet::development_vm]',
    ]
  end
end
