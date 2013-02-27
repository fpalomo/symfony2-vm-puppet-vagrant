class timezone ( $timezone = 'UTC' ) {

    file { '/etc/sysconfig/clock':
        mode => 644,
        owner => root,
        group => root,
        ensure => present,
        path => '/etc/sysconfig/clock',
        content => template('timezone/clock.erb'),
        notify => Exec['tzdata-update'],
    }

    exec { 'tzdata-update':
        command => '/usr/sbin/tzdata-update',
        require => File['/etc/sysconfig/clock'],
        refreshonly => true,
    }

}
