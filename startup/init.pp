class startup {
  $package_list=['vim',
                'wget',
                'ag',
                'epel-release',]
  
  $vimrc = '/home/vagrant/.vimrc'
      
  
  package {$package_list:
      ensure => 'latest'
          }
  
  file {$vimrc:
      ensure => 'present',
      source => 'vimrc'
      }

}


