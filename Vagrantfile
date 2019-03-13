# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant virtual environments for SQL Server 2017 on Ubuntu Linux

Vagrant.configure(2) do |config|
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb, override|
    vb.name = "vagrant-mssql"
    vb.memory = "4096"
    vb.cpus = 4
    # Do not use official Ubuntu box, broken in many ways https://bugs.launchpad.net/cloud-images/+bug/1569237
    override.vm.box = "bento/ubuntu-16.04"
    override.vm.network "private_network", type: "dhcp"
    override.vm.network :forwarded_port, host: 2433, guest: 1433  # SQLServer
  end

  config.vm.provider "hyperv" do |hv, override|
    hv.vmname = "vagrant-mssql"
    hv.memory = "4096"
    hv.cpus = 4
    override.vm.box = "bento/ubuntu-16.04"
    override.vm.synced_folder ".", "/vagrant", disabled: true
    # Windows (Build 16237+) comes with "Default Switch" to allow VMs to NAT host internet (any!) connection
    # https://blogs.technet.microsoft.com/virtualization/2017/07/26/hyper-v-virtual-machine-gallery-and-networking-improvements/
    # Apparently, this is an undocumented workaround to specify Hyper-V network in Vagrantfile.
    # NOTE: By default, try the "Default Switch"
    #       Alternatively, comment this line and let Vagrant prompt you to select one from available Hyper-V Switch-es.
    #override.vm.network "private_network", bridge: "Default Switch"
    #override.vm.network "public_network", bridge: "External Switch"
  end

  scripts = [ "bootstrap.sh" ]
  scripts.each { |script|
    config.vm.provision :shell, privileged: false, :path => "./" << script
  }

end
