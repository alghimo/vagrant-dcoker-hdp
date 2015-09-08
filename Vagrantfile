# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "vagrant-ubuntu-dev"

  # Disable automatic box update checking.
  config.vm.box_check_update = false

  #config.vm.network "forwarded_port", guest: 3306, host: 3306

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.24.43"

  # Customize virtualbox memory, CPUs and VM name
  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.customize ['modifyvm', :id, '--memory', "16384"]
    virtualbox.customize ['modifyvm', :id, '--cpus', "8"]
    virtualbox.customize ['modifyvm', :id, '--name', config.vm.hostname]
  end

  # If the hostmanager plugin available, automatically add the host name and alias to our /etc/hosts file
  if Vagrant.has_plugin?('vagrant-hostmanager')
    hosts = Array.new()
    hosts.push(config.vm.hostname)
    hosts.push("ubuntu.local.dev")
    hosts.push("ambari.local.dev")
    config.hostmanager.enabled           = true
    config.hostmanager.manage_host       = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline   = false
    config.hostmanager.aliases           = hosts
  end

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./projects", "/projects"

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    echo "\033[32mInstalling Docker Experimental (1.9.0-dev)\033[0m\n"
    #echo "curl -sSL https://get.docker.com/ | sh\n"
    #curl -sSL https://get.docker.com/ | sh
    echo "curl -sSL https://experimental.docker.com/ | sh\n"
    curl -sSL https://experimental.docker.com/ | sh
    echo "\033[32mAdding the vagrant user to docker group...\033[0m\n"
    echo "sudo usermod -aG docker vagrant\n"
    sudo usermod -aG docker vagrant
    echo "\033[32mInstalling Apache2...\033[0m\n"
    echo "sudo apt-get install apache2\n"
    sudo apt-get install apache2
    echo "\033[32mCreating proxy for ambari.local.dev...\033[0m\n"
    echo "sudo mv /projects/files/etc/apache2/sites-enabled/001-ambari.conf /etc/apache2/sites-enabled/\n"
    sudo mv /projects/files/etc/apache2/sites-enabled/001-ambari.conf /etc/apache2/sites-enabled
    echo "\033[32mEnabling proxy modules...\033[0m\n"
    echo "sudo a2enmod proxy*\n"
    sudo a2enmod proxy*
    echo "\033[32mRestarting Apache2...\033[0m\n"
    echo "sudo apachectl restart\n"
    sudo apachectl restart
  SHELL

  # config.vm.provision "shell", run: "always", inline: <<-SHELL
  #   echo "\033[32mCreating docker network 'hdpcluster'\033[0m\n"
  #   echo "docker network create hdpcluster\n"
  #   docker network create hdpcluster
  #   echo "\033[32mCreating bind address for interface eth1\033[0m\n"
  #   echo "sudo ip addr add 10.12.0.117/21 dev eth1\n"
  #   sudo ip addr add 10.12.0.117/21 dev eth1
  # SHELL
end
