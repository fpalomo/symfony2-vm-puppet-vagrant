class phpmyadmin {
    package {
        "phpMyAdmin" :
            ensure => present ;
    }
    file {
        "/etc/phpMyAdmin/config.inc.php" :
            owner => root,
            group => root,
            mode => 644,
            source => "puppet:///modules/phpmyadmin/config.inc.php",
            require => [Package["phpMyAdmin"]]
    }
    file {
        "/etc/httpd/conf.d/phpMyAdmin.conf" :
            owner => root,
            group => root,
            mode => 644,
            source => "puppet:///modules/phpmyadmin/phpMyAdmin.conf",
            require => [Package["httpd"]]
    }
}
