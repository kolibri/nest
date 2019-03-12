# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ko_arch"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.hostname = "aerith.dev"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "2048"
  end
   config.vm.provision "ansible" do |ansible|
    ansible.playbook = "site.yml"
    ansible.limit = "all"
    ansible.config_file = "ansible.cfg"
    ansible.inventory_path = "inventory/vagrant"
  end  
end
