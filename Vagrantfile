# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Base VM OS configuration.
  config.vm.box = "geerlingguy/centos7"
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |v|
    v.memory = 1024
    v.cpus = 2
    v.linked_clone = true
  end

  # Define four VMs with static private IP addresses.
  boxes = [
    { :name => "reverse-proxy.test", :ip => "192.168.4.30" },
    { :name => "appnav-01.test", :ip => "192.168.4.31" },
    { :name => "student-ssb-01.test", :ip => "192.168.4.32" },
    { :name => "registration-ssb-01.test", :ip => "192.168.4.34" },
    { :name => "registration-ssb-02.test", :ip => "192.168.4.34" },
    { :name => "control.test", :ip => "192.168.4.20" }
  ]

  # Provision each of the VMs.
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]
      config.vm.network :private_network, ip: opts[:ip]

      # Provision all the VMs using Ansible after last VM is up.
      if opts[:name] == "control.test"
        tomcat.vm.provision "shell", inline: <<-SHELL
          sudo setenforce 0
          sudo yum install -y ansible
        SHELL
        # config.vm.provision "ansible" do |ansible|
        #   ansible.playbook = "playbooks/main.yml"
        #   ansible.inventory_path = "inventory"
        #   ansible.limit = "all"
        end
      end
    end
  end

end



  # config.vm.define "tomcat" do |tomcat|
  #   tomcat.vm.box = "geerlingguy/centos7"
  #   tomcat.vm.hostname = "tomcat-vm"
  #   tomcat.vm.network "forwarded_port", guest: 8080, host: 8081
  #   tomcat.vm.network "private_network", ip: "192.168.33.11"

  #   tomcat.vm.provision "shell", inline: <<-SHELL
  #     sudo setenforce 0
  #   SHELL

  #   # Ansible stuff
  #   tomcat.vm.provision :ansible do |ansible|
  #     ansible.verbose = true
  #     ansible.playbook = "tomcat.yml"
  #   end
  # end

  # config.vm.define "web" do |web|
  #   web.vm.box = "geerlingguy/centos7"
  #   web.vm.hostname = "apache-vm"
  #   web.vm.network "forwarded_port", guest: 80, host: 81
  #   web.vm.network "private_network", ip: "192.168.33.12"
  #   web.vm.network "public_network", bridge: "en0: Wi-Fi (Wireless)"

  #   web.vm.provision "shell", inline: <<-SHELL
  #     sudo setenforce 0
  #   SHELL

  #   # Ansible stuff
  #   web.vm.provision :ansible do |ansible|
  #     ansible.verbose = true
  #     ansible.playbook = "apache.yml"
  #   end

  # end
