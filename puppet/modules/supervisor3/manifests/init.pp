class supervisor3 {

    package { 'python-setuptools':
        ensure => present
    }

    exec { "easy_install supervisor":
        alias => "install-supervisor",
        require => Package['python-setuptools'],
        path => "/usr/local/bin:/usr/bin:/bin",
        unless => "which supervisor",
    }

    file { "/etc/supervisord.conf":
          owner  => root,
          group  => root,
          mode   => 644,
          source => "puppet:///modules/supervisor3/supervisord.conf"
    }

    file { "/etc/init.d/supervisord":
          owner  => root,
          group  => root,
          mode   => 744,
          source => "puppet:///modules/supervisor3/supervisord"
    }

    exec { "sudo chkconfig --level 345 supervisord on":
        alias => "supervisord-service",
        path => "/usr/local/bin:/usr/bin:/bin",
        require => [ File["/etc/supervisord.conf"], File["/etc/init.d/supervisord"], Exec["install-supervisor"] ],
        returns => [0, 1]
    }

    service { "supervisord":
        enable => true,
        require => Exec["supervisord-service"];
    }

}


