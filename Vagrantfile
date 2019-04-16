# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = [{
    :name => :aerith_dev,
    :host => "aerith.dev",
    :ip   => "192.168.31.10",
    :gui  => true,
    :box  => "ko_arch",
},{
    :name => :bugenhagen_dev,
    :host => "bugenhagen.dev",
    :ip   => "192.168.31.11",
    :gui  => true,
    :box  => "ko_arch",
}]

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    boxes.each do |opts|
        config.vm.define opts[:name], autostart: false do |config|
            config.vm.box = opts[:box]
            config.vm.network "private_network", ip: opts[:ip]
            config.vm.host_name = opts[:host]
            config.vm.provider :virtualbox do |virtualbox|
                virtualbox.gui = opts[:gui]
                virtualbox.customize ["modifyvm", :id, "--name", opts[:host]]
                virtualbox.customize ["modifyvm", :id, "--memory", "2048"]
                virtualbox.customize ["modifyvm", :id, "--vram", "128"]
            end

            config.vm.provision "ansible" do |ansible|
                ansible.playbook = "site.yml"
                ansible.limit = opts[:host]
                ansible.config_file = "ansible.cfg"
                ansible.inventory_path = "inventory/vagrant"
            end  
        end
    end
end
