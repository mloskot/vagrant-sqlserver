# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant virtual environments for SQL Server 2017 on Ubuntu Linux

# All Vagrant configuration is done below.
# For a configuration reference go to https://docs.vagrantup.com.
# The "2" in Vagrant.configure configures the configuration version.
# Please don't change it unless you know what you're doing.
Vagrant.configure(2) do |config|
  # ubuntu/xenial64 is broken, does not provide vagrant user
  # see https://bugs.launchpad.net/cloud-images/+bug/1569237
  config.vm.box = "boxcutter/ubuntu1610"
  config.vm.box_check_update = true
  config.vm.network :forwarded_port, host: 2433, guest: 1433
  config.vm.network "private_network", type: "dhcp"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 4
  end

  config.vm.provision :file, source: 'mssqlconfhelper.py.patch', destination: 'mssqlconfhelper.py.patch'

  scripts = [ "bootstrap.sh" ]
  scripts.each { |script|
    config.vm.provision :shell, privileged: false, :path => "./" << script
  }

end
