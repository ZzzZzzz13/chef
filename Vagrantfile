# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false


  # Chef Client #1 - CentOS Stream 9
  config.vm.define "web" do |web|
    web.vm.box = "shekeriev/centos-stream-9"
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.99.100"
    web.vm.network "forwarded_port", guest: 80, host: 8000, auto_correct: true
    web.vm.provision "shell", path: "add_hosts.sh"
    web.vm.provision "chef_solo" do |chef|
      chef.arguments = "--chef-license accept"
      chef.add_recipe "apache"
    end
    
    web.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 1024
      v.cpus = 1
    end
  end

  # Chef Client #2 - Debian 11
  config.vm.define "db" do |db|
    db.vm.box = "shekeriev/debian-11"
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.99.101"
    db.vm.synced_folder "vagrant/db/", "/vagrant"
    db.vm.provision "shell", path: "add_hosts.sh"
    db.vm.provision "chef_solo" do |chef|
      chef.arguments = "--chef-license accept"
      chef.add_recipe "mariadb"
    end

    db.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 1024
      v.cpus = 1
    end
  end
  
end
