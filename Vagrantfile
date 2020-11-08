# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.define "tomcat" do |tomcat|
    tomcat.vm.box = "geerlingguy/centos7"
    tomcat.vm.hostname = "tomcat-vm"
    tomcat.vm.network "forwarded_port", guest: 8080, host: 8081
    tomcat.vm.network "private_network", ip: "192.168.33.11"

    tomcat.vm.provision "shell", inline: <<-SHELL
      sudo setenforce 0
    SHELL

    # Ansible stuff
    tomcat.vm.provision :ansible do |ansible|
      ansible.verbose = true
      ansible.playbook = "tomcat.yml"
    end
  end

  config.vm.define "web" do |web|
    web.vm.box = "geerlingguy/centos7"
    web.vm.hostname = "apache-vm"
    web.vm.network "forwarded_port", guest: 80, host: 81
    web.vm.network "private_network", ip: "192.168.33.12"
    web.vm.network "public_network", bridge: "en0: Wi-Fi (Wireless)"

    web.vm.provision "shell", inline: <<-SHELL
      sudo setenforce 0
    SHELL

    # Ansible stuff
    web.vm.provision :ansible do |ansible|
      ansible.verbose = true
      ansible.playbook = "apache.yml"
    end

  end

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "geerlingguy/centos7"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  #config.vm.box_url = "https://oracle.github.io/vagrant-projects/boxes/oraclelinux/7.json"

  
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  
  
  #config.vm.network "forwarded_port", guest: 8880, host: 8880

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  
  #config.vm.network "public_network", bridge: "en0: Wi-Fi (Wireless)"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.cpus = "4"
    vb.memory = "2048"
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.

  # Disable selinux
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo setenforce 0
  # SHELL
  

  
end
