# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
if !Vagrant.has_plugin?("vagrant-proxyconf")
  system "vagrant plugin install vagrant-proxyconf"
end
Vagrant.configure("2") do |config|
  BOX_IMAGE = "ubuntu/jammy64"
  PROXY = "http://10.20.5.51:8888"
  NO_PROXY = "localhost,127.0.0.1"
  PROXY_ENABLE = true
  BASE_INT_NETWORK = "10.10.20"
  BASE_HOST_ONLY_NETWORK = "192.168.56"
  WEB_NAME = "web.m340"
  DB_NAME = "db.m340"

  config.vm.define DB_NAME do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = DB_NAME
    if PROXY_ENABLE
      subconfig.proxy.http = PROXY
      subconfig.proxy.https = PROXY
      subconfig.proxy.no_proxy = NO_PROXY
    end
    subconfig.vm.network "private_network", ip: "#{BASE_INT_NETWORK}.11", virtualbox__intnet: true
    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = DB_NAME
      vb.gui = true
      vb.memory = "2048"
    end
    subconfig.vm.provision "shell", path: "scripts/provision_db.sh"
  end

  config.vm.define WEB_NAME do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = WEB_NAME
    if PROXY_ENABLE
      subconfig.proxy.http = PROXY
      subconfig.proxy.https = PROXY
      subconfig.proxy.no_proxy = NO_PROXY
    end
    subconfig.vm.network "private_network", ip: "#{BASE_INT_NETWORK}.10", virtualbox__intnet: true
    subconfig.vm.network "private_network", ip: "#{BASE_HOST_ONLY_NETWORK}.10"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = WEB_NAME
      vb.gui = true
      vb.memory = "2048"
    end
    subconfig.vm.synced_folder "./site", "/var/www/html"
    subconfig.vm.provision "shell", path: "scripts/provision_web.sh"
  end
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
