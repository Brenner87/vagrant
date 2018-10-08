class jenkins ($base_version){
    $packages=['jenkins',]
    package {$packages:
        ensure => $base_version,
    }

}
