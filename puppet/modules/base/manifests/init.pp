class base ($base_version){

  include base::handle_users

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
      ensure => $base_version,
          }

  $home_dirs.each |$value| {
    file {"$value.vimrc":
        ensure => 'present',
        source => 'puppet:///modules/base/vimrc',
        owner  => split($value, '/')[-1],
        require => Package[$package_list],
        }
  }
  
}
