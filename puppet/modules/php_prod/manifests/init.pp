class php_prod ( $php = "php54" ) {

    $oldPhpPackages = [
        "php-5.3.3",
        "php-cli-5.3.3",
        "php-common",
    ]

    package { $oldPhpPackages:
        ensure => "absent"
    }




    $packages = [
        "$php",
        "$php-devel",
        "$php-gd",
        "$php-mbstring",
        "$php-pdo",
        "$php-cli",
        "$php-mysql",
        "$php-xml",
        "$php-pspell",
        "$php-pear",
        "$php-common",
        "$php-mcrypt",
        "$php-pecl-memcache",
        "$php-pecl-imagick",
    ]


    $repo = 'epel'
    $extra = [ "$php-pecl-apc" ]

    package { $packages:
        ensure => present,
        require => Yumrepo[$repo],
    }


    package { $extra:
        ensure => present,
        require => Yumrepo[$repo],
    }

    file {'/etc/httpd/conf.d/php.conf':
        owner => root,
        group => root,
        mode => 644,
        source => 'puppet:///modules/php_prod/php.conf',
        require => Package[$php],
        notify => Service['httpd'],
    }

    file {'/etc/php.d/my-stuff-php.ini':
        owner => root,
        group => root,
        mode => 644,
        source => 'puppet:///modules/php_prod/php.ini',
        require => Package[$php],
        notify => Service['httpd'],
    }
}


