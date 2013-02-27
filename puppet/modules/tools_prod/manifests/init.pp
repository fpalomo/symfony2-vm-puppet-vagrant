class tools_prod {

    $packages = [
        "htop",
        "iftop",
        "mytop",
        "iotop",
        "vim-enhanced",
    ]

    package { $packages :
        ensure => latest,
        require => $operatingsystem ? {
            'redhat' => Yumrepo['epel'],
            'centos' => Yumrepo['epel'],
            'fedora' => undef,
            default => undef,
        }
    }
}
