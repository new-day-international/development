# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_plugin 'vagrant-berkshelf'
Vagrant.require_plugin 'vagrant-omnibus'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
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

  config.vm.provision :chef_solo do |chef|
    defaults = {
      java: {
       	oracle: {
          'accept_oracle_download_terms' => true
        }
      },
      lightnet: {
        domain_name: 'localdev.lightnet.is',
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
    settings = YAML.load_file('settings.yml').deep_symbolize_keys!
    chef.json = defaults.deep_merge!(settings)

    chef.run_list = [
      'recipe[lightnet::development_vm]',
    ]
  end

end
