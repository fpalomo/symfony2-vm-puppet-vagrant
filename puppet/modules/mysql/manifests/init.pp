class mysql {
    include yum_prod::ius

    $version = 'latest'

    package { 'mysql55-server':
        ensure => $version,
        alias => 'mysql-server',
        require => Yumrepo['ius'],
    }

    package { 'mysql55':
        ensure => $version,
        alias => 'mysql',
        require => Yumrepo['ius'],
    }

    package { 'mysql55-libs':
        ensure => $version,
        alias => 'mysql-libs',
        require => Yumrepo['ius'],
    }

    package { 'mysqlclient16':
        ensure => present,
        require => Yumrepo['ius'],
    }

    service { 'mysqld':
        ensure    => running,
        enable    => true,
        require   => Package['mysql-server'],
    }
}
