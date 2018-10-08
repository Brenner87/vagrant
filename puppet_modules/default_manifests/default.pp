notice $hostname
if $hostname =~ /^jenkins\d*/ {  
    include 'role::jenkins'
}

