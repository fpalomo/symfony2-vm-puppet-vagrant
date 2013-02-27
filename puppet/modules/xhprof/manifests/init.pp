class xhprof {
    $tld_domain = "vagrant"

    package { "php-pecl-xhprof":
        ensure => latest,
        require => [ Package["httpd"],Package["php54"] ],
        notify => Service["httpd"]
    }

    package { "graphviz":
        ensure => latest,
    }

    file { "/etc/httpd/conf.d/xhprof.conf":
        owner  => root,
        group  => root,
        mode   => 644,
        content => template("xhprof/xhprof.conf.erb"),
        require => [ Package["httpd"], Exec["create-db-xhprof"] ],
        notify => Service["httpd"]
    }

    file { "/etc/php.d/xhprof.ini":
        ensure => absent
    }

    file { "/var/www/xhprof":
        ensure => "directory",
        require => Package["httpd"]
    }

    file { "/var/www/xhprof/xhprof_lib/config.php":
      source => "puppet:///modules/xhprof/config.php",
      require => Exec["unpack xhgui"]
    }

    file { "/var/www/xhprof/xhprof.tgz":
      source => "puppet:///modules/xhprof/xhprof.tgz",
      notify => Exec["unpack xhgui"],
      require => File["/var/www/xhprof/"]
    }

    exec { "unpack xhgui":
        command => "/bin/tar x -C /var/www/xhprof -f /var/www/xhprof/xhprof.tgz --strip-components=1",
        creates => "/var/www/xhprof/xhprof_html",
        require => File["/var/www/xhprof/xhprof.tgz"]
    }

    file { "/root/xhprof.mysql":
      owner  => root,
      group  => root,
      mode   => 644,
      source => "puppet:///modules/xhprof/xhprof.mysql",
      notify => Exec["create-db-xhprof"]
    }

    exec { "create-db-xhprof":
      unless => "/usr/bin/mysql xhprof",
      command => "/usr/bin/mysqladmin create xhprof; /usr/bin/mysql xhprof < /root/xhprof.mysql",
      require => [ Service["mysqld"], File["/root/xhprof.mysql"]],
    }

}
