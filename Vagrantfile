# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = [{
    :name => :cid_dev,
    :host => "cid.dev",
    :ip   => "192.168.31.102",
    :gui  => true,
    :box  => "terrywang/archlinux",
    :sync_host => ".",
    :sync_guest => "/home/vagrant/nest"
},{
    :name => :seto_dev,
    :host => "seto.dev",
    :ip   => "192.168.31.103",
    :gui  => false,
    :box  => "geerlingguy/ubuntu1804",
    :sync_host => ".",
    :sync_guest => "/home/vagrant/nest"
},{
    :name => :cloud_dev,
    :host => "cloud.dev",
    :ip   => "192.168.31.104",
    :gui  => false,
    :box  => "terrywang/archlinux",
    :sync_host => ".",
    :sync_guest => "/home/vagrant/nest"
}
]

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    boxes.each do |opts|
        config.vm.define opts[:name], autostart: false do |config|
            config.vm.box = opts[:box]
            config.vm.network "private_network", ip: opts[:ip]
            config.vm.host_name = opts[:host]
            config.vm.synced_folder opts[:sync_host], opts[:sync_guest], id: "vagrant-share", :nfs => true
            #config.vm.synced_folder "/Users/ko/Desktop/media", "/home/vagrant/libri/media", id: "media-share", :nfs => true

            # config.ssh.username = "vagrant"
            # config.ssh.password = "vagrant"

            config.vm.provider :virtualbox do |virtualbox|
                virtualbox.gui = opts[:gui]
                virtualbox.customize ["modifyvm", :id, "--name", opts[:host]]
                virtualbox.customize ["modifyvm", :id, "--memory", "2048"]
                virtualbox.customize ["modifyvm", :id, "--vram", "32"]
                virtualbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
                virtualbox.customize ["setextradata", :id, "--VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
            end

        end
    end
end
