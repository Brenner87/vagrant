(( $# < 2 )) && echo "usage: kickstart.sh <path to packs> <puppet master ip>" && exit
repo_path=$1
ip_addr=$2
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
        . /vagrant/master_config/root_bash_profile
        yum -y install git
        yum -y install puppetserver-5.3.5-1.el7.noarch
        systemctl stop puppetserver
        cp /vagrant/master_config/puppetserver /etc/sysconfig/puppetserver
        cp /vagrant/master_config/puppet.conf /etc/puppetlabs/puppet/puppet.conf
        cp /vagrant/master_config/autosign.conf /etc/puppetlabs/puppet/autosign.conf
        cp /vagrant/master_config/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml
        rm -rf /etc/puppetlab/puppet/ssl
        puppet cert list -a
        systemctl start puppetserver
        mkdir  /etc/puppetlabs/r10k
      	gem install r10k
        cp /vagrant/master_config/r10k.yaml /etc/puppetlabs/r10k/r10k.yaml
        rm -rf /etc/puppetlabs/code/environments/*
        r10k deploy environment -p
        mkdir /etc/puppetlabs/puppet/keys/
        cp /vagrant/keys/* /etc/puppetlabs/puppet/keys/
        chown puppet:puppet /etc/puppetlabs/puppet/keys/*
        systemctl restart puppetserver
    fi
fi
sh -c "echo \"$ip_addr puppetmaster.vagrant.com puppetmaster\" >> /etc/hosts"
/opt/puppetlabs/bin/puppet agent --certname=$(hostname) --server=puppetmaster.vagrant.com --environment=production --verbose --onetime --no-daemonize

