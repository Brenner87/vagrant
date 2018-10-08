notice $hostname
if $hostname =~ /^jenkins/ {  
    include 'role::jenkins'
}

