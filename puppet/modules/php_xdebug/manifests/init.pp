class php_xdebug {
    package { "php54-pecl-xdebug":
        ensure => present,
        notify => Service["httpd"],
        require => [ Yumrepo['epel'], Package['httpd'] ],
    }

    file { "/etc/php.d/xdebug.ini":
          owner  => root,
          group  => root,
          mode   => 644,
          source => "puppet:///modules/php_xdebug/xdebug.ini",
          require => [ Package['php54-pecl-xdebug'], Package['httpd'] ],
          notify => Service["httpd"]
    }
}
