# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  #config.vm.box = "base"
  config.vm.box = "chef/ubuntu-14.04"

  config.vm.host_name = "es-playground"

  config.vm.network :private_network,ip:"192.168.50.5"

  config.vm.provider "virtualbox" do |vb|
    vb.customize [ "modifyvm", :id, "--memory", 1024]
    vb.customize [ "modifyvm", :id, "--name", "es-playground"]
  end

  config.vm.provision "chef_solo" do |chef|
  chef.cookbooks_path = ["cookbooks"]
  chef.add_recipe "elasticsearch-playground::default"
  end
end
