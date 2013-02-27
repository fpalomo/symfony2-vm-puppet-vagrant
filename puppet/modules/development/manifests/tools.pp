class development::tools inherits development::params {
    include tools_prod

    $packages = [
        "git",
        "strace",
        "nano",
        "ant",
    ]

    package { $packages :
        ensure => latest,
        require => $operatingsystem ? {
            'redhat' => Yumrepo['epel'],
            'fedora' => undef,
            default => undef,
        }
    }
}
