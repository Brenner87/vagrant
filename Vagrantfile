# -*- mode: ruby -*-
# vi: set ft=ruby :
# add appropriate entries to hosts file
# ensure you have all folders specified below, or configure yours

#=============================================================
#-----------------------Configuration-------------------------
#=============================================================

hosts = {
    'jenkins.vagrant.com' => {
        'addr'  => '192.168.56.111', 
        'mem'   => 2048, 
        'cpus'  => 1, 
        'image' => "bento/centos-7.4"},
    'db.vagrant.com'      => {
        'addr' => '192.168.56.112', 
        'mem' => 512,
        'cpus' => 1,
        'image' => "bento/centos-7.4"},
    'web.vagrant.com'     => {
        'addr' => '192.168.56.113',
        'mem' => 1024,
        'cpus' => 1,
        'image' => "bento/centos-7.4"},
    'puppetmaster.vagrant.com'     => {
        'addr' => '192.168.56.114',
        'mem' => 1024,
        'cpus' => 1,
        'image' => "bento/centos-7.4"},
}
master_ip        = hosts['puppetmaster.vagrant.com']['addr']
vagrant_stuff    = '/Users/brenner/vagrant'
source_mount     = vagrant_stuff
dest_mount       = '/vagrant'
puppet_modules   = "#{vagrant_stuff}/puppet/modules"
vagrant_scripts  = "#{vagrant_stuff}/scripts"

#=============================================================
#---------------------------Code------------------------------
#=============================================================

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
    inline: "/bin/bash #{dest_mount}/scripts/kickstart.sh #{dest_mount}/packages #{master_ip}",
    privileged: true
#  config.vm.provision "puppet" do |puppet|
    #puppet.puppet_server="puppetmaster.vagrant.com"
#    puppet.manifests_path = "#{puppet_modules}/manifests/init.pp"
#    puppet.module_path = puppet_modules
#    puppet.hiera_config_path = '/Users/brenner/vagrant/puppet/hiera.yaml'
#    puppet.working_directory = '/tmp/vagrant-puppet/'
#  end
end


