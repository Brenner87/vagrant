class startup {
  $package_list=['epel-release',
                'automake',
                'vim-enhanced',
                'wget',
                'pcre-devel',
                'xz-devel',
                'git',
                'the_silver_searcher',
                ]
  $home_dirs = ['/home/vagrant/', '/root/',]
  #$vimrc = ['/home/vagrant/.vimrc']
  #$ag_script = '/tmp/install_ag.sh'

  package {$package_list:
      ensure => 'latest',
          }

  $home_dirs.each |$value| {
    file {"$value.vimrc":
        ensure => 'present',
        source => 'puppet:///modules/startup/vimrc',
        owner  => split($value, '/')[-1],
        require => Package[$package_list],
        }
  }
  
#  file {$ag_script:
#    ensure => 'file',
#    source => 'puppet:///modules/startup/install_ag.sh',
#    mode   => '755',
#    owner  => 'root',
#    notify => Exec[install_ag],
#  }
#
#  exec {install_ag:
#    command => "/usr/bin/bash $ag_script",
#    unless  =>  "/usr/bin/yum list installed ag",
#    user    => "root",
#  }

}
