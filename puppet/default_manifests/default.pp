notice $hostname
#if $hostname =~ /^jenkins/ {  
#    include 'role::jenkins'
#}
#if $hostname =~/^puppetmaster/ {
#    include 'role::puppetmaster'
#}

node /^jenkins.*vagrant\.com/ {  
    include 'role::jenkins'
}

node /^puppetmaster.*vagrant\.com/ {
    include 'role::puppetmaster'
}
