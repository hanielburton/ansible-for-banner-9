# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Base VM OS configuration.
  config.vm.box = "geerlingguy/centos7"
  config.vm.synced_folder '.', '/vagrant', disabled: false
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |v|
    v.memory = 1024
    v.cpus = 4
    v.linked_clone = true
  end

  # Define 7 VMs with static private IP addresses.
  boxes = [
    { :name => "apache-web-tier-dev-01", :ip => "192.168.4.10", :auto_start => true },
    { :name => "appnav-dev-01", :ip => "192.168.4.11", :auto_start => true},
    { :name => "appnav-dev-02", :ip => "192.168.4.12", :auto_start => true },
    { :name => "ssb-registration-dev-01", :ip => "192.168.4.14", :auto_start => true},
    { :name => "ssb-registration-dev-02", :ip => "192.168.4.15", :auto_start => true },
    { :name => "ssb-student-dev-01", :ip => "192.168.4.16", :auto_start => true},
    { :name => "ansible-control", :ip => "192.168.4.20", :auto_start => true }
  ]

  # Provision each of the VMs.
  boxes.each do |opts|
    config.vm.define opts[:name], autostart: opts[:auto_start] do |config|
      config.vm.hostname = opts[:name]
      config.vm.network :private_network, ip: opts[:ip]

      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "setup.yml"
        ansible.verbose = true
        #ansible.inventory_path = "inventory"
        ansible.limit = "all"

      # Provision the control VM using Ansible after last VM is up.
      if opts[:name] == "ansible-control"
        #config.vm.define primary: true
        config.vm.synced_folder '.', '/vagrant', disabled: false
        config.vm.provision "shell", inline: <<-SHELL
          sudo setenforce 0
          sudo yum install -y vim
          . /vagrant/provision_hosts.bash
        SHELL
        
        end
      end
    end
  end
end


