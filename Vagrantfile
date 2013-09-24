# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.omnibus.chef_version = '10.14.2'
  config.vm.box = "precise64"
  config.vm.network :private_network, ip: "33.33.33.10"
  config.berkshelf.enabled = true

  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "3072"]
  end

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      java: {
       	oracle: {
          "accept_oracle_download_terms" => true
        }
      },
      lightnet: {
        domain_name: 'localdev.lightnet.is'
      },
      postgresql: {
        password: {
          postgres: 'password',
        }
      },
    }

    unless ENV['LIGHTNET_PRODUCTION']
      chef.json[:lightnet].merge!({
        create_user: false,
        application_directory: '/vagrant',
        user: 'vagrant',
        group: 'vagrant',
      })
    end

    chef.run_list = [
      "recipe[lightnet::development_vm]",
    ]
  end

end
