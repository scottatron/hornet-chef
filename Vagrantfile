# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname          = "hornet"
  config.vm.box               = "opscode-ubuntu-12.04"
  config.vm.box_url           = "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box"
  config.omnibus.chef_version = :latest
  config.berkshelf.enabled    = true
  config.vm.network :private_network, ip: "33.33.33.10"
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      mysql: {
        server_root_password:   'root',
        server_debian_password: 'root',
        server_repl_password:   'root'
      },
      nginx: {
        default_site_enabled: false
      }
    }
    chef.run_list = [
      "recipe[hornet::default]",
      "recipe[hornet::captain]",
      "recipe[hornet::ruby]",
      "recipe[hornet::mysql]",
      "recipe[hornet::nginx]"
    ]
  end
end
