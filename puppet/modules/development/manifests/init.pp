class development inherits development::params {
    stage { 'yum': before => Stage[main] }
    class { 'yum_prod::centos': stage => yum }
    class { 'yum_prod::epel': stage => yum }
    class { 'yum_prod::ius': stage => yum }


    include mysql
    include development::httpd
    include php_xdebug
    include phpmyadmin
    include supervisor3

    class { 'timezone': timezone => 'UTC' }

    class { "php_prod":
        php => "php54"
    }
  
    include development::tools

    # disable firewall, which is enabled in newer basebox
    service { "iptables": ensure => stopped, enable => false }

    file { "/var/www/log":
      owner  => apache,
      group  => apache,
      mode   => 777,
      ensure => directory,
      require => [ Package["httpd"] ]
    }

    file { "/etc/php.d/php.ini":
      owner  => root,
      group  => root,
      mode   => 644,
      source => "puppet:///modules/development/php.ini",
      require => [ Package["httpd"], Package["php54"] ],
      notify => Service["httpd"]
    }






}

node default{
	include development
}

