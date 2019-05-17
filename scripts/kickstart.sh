(( $# < 2 )) && echo "usage: kickstart.sh <path to packs> <puppet master ip>" && exit
repo_path=$1
ip_addr=$2
puppet_conf=/etc/puppetlabs/puppet
yum -y install createrepo
createrepo $repo_path
repofile='/etc/yum.repos.d/local-repo.repo'
(ls $repofile 2>/dev/null) || echo "[local-repo]
name='Local REPO'
baseurl=file://$1
enabled=1
gpgcheck=0">$repofile
(yum list installed puppet-agent 2>/dev/null) || yum -y install puppet-agent

if [[ `hostname` =~ ^puppetmaster ]]
then
    if ! ps -ef | grep -q [p]uppetserver
    then
        yum -y install git
        yum -y install puppetserver-5.3.5-1.el7.noarch
        systemctl stop puppetserver
        rm -rf $puppet_conf
        git clone https://github.com/Brenner87/puppet_config.git $puppet_conf
        cd $puppet_conf
        . profile
        mv ./puppetserver /etc/sysconfig/puppetserver
        puppet cert list -a
#        systemctl start puppetserver
        mkdir  /etc/puppetlabs/r10k
      	gem install r10k
        mv ./r10k.yaml /etc/puppetlabs/r10k/r10k.yaml
        rm -rf /etc/puppetlabs/code/environments/*
        r10k deploy environment -p
        cp /vagrant/keys/* /etc/puppetlabs/puppet/keys/
        chown puppet:puppet /etc/puppetlabs/puppet/keys/*
        systemctl start puppetserver
        systemctl enable puppetserver
    fi
fi
sh -c "echo \"$ip_addr puppetmaster.vagrant.com puppetmaster\" >> /etc/hosts"
/opt/puppetlabs/bin/puppet agent --certname=$(hostname) --server=puppetmaster.vagrant.com --environment=production --verbose --onetime --no-daemonize

