yum -y install createrepo
createrepo $1
repofile='/etc/yum.repos.d/local-repo.repo'
(ls $repofile 2>/dev/null) || echo "[local-repo]
name='Local REPO'
baseurl=file://$1
enabled=1
gpgcheck=0">$repofile
(yum list installed puppet-agent 2>/dev/null) || yum -y install puppet-agent

