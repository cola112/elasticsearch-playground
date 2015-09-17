# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "base"

  config.vm.host_name = "estester"

  config.vm.network :private_network,ip:"192.168.50.5"

  config.vm.provider "virtualbox" do |vb|
    vb.customize [ "modifyvm", :id, "--memory", 1024]
    vb.customize [ "modifyvm", :id, "--name", "estester"]
  end

  config.vm.provision "chef_solo" do |chef|
  chef.cookbooks_path = ["cookbooks"]
  chef.add_recipe "elasticsearch-tester::default"
  end
end
