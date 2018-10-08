# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.


hosts = {
    'jenkins.vagrant.com' => {
        'addr'  => '192.168.56.111', 
        'mem'   => 512, 
        'cpus'  => 1, 
        'image' => "bento/centos-7.4"},
    'db.vagrant.com'      => {
        'addr' => '192.168.56.112', 
        'mem' => 512,
        'cpus' => 1,
        'image' => "bento/centos-7.4"},
    'web.vagrant.com'     => {
        'addr' => '192.168.56.113',
        'mem' => 512,
        'cpus' => 1,
        'image' => "bento/centos-7.4"},
}
vagrant_stuff    = '/Users/brenner/vagrant'
source_mount     = vagrant_stuff
dest_mount       = '/vagrant'
puppet_modules   = "#{vagrant_stuff}/puppet/modules"
vagrant_scripts  = "#{vagrant_stuff}/vagrant_scripts"

Vagrant.configure("2") do |config|
config.vm.synced_folder source_mount, dest_mount 
  hosts.each { |host, params|
    config.vm.define host do |item|
  	item.vm.box = params['image']
      item.vm.hostname = host
      #web.vm.box_url = "centos/7"
  
      item.vm.network :private_network, ip: params['addr']
  
      item.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", params['mem']]
        v.customize ["modifyvm", :id, "--name", host]
        v.customize ["modifyvm", :id, "--cpus", params['cpus']]
      end
    end
  }
  config.vm.provision "shell", 
    #path: "#{vagrant_scripts}/puppet_install.sh"
    inline: "/bin/bash #{dest_mount}/vagrant_scripts/first_install.sh #{dest_mount}/packages",
    privileged: true
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "#{puppet_modules}/../default_manifests"
    puppet.module_path = puppet_modules
    puppet.hiera_config_path = '/Users/brenner/vagrant/puppet/hiera.yaml'
    puppet.working_directory = '/tmp/vagrant-puppet/'
  end
end





#Vagrant.configure("2") do |config|
#  config.vm.box = "centos/7"
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.


  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "fo/rwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

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

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
#end
