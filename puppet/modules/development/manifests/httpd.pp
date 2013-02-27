class development::httpd inherits development::params {
  package { "httpd": ensure => present; }
  package { "openssl": ensure => present; }
  package { "mod_ssl": ensure => present; }

  file { "/etc/httpd/conf/httpd.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/development/httpd.conf",
    require => [ Package["httpd"] ],
    notify => Service["httpd"]
  }


  service { "httpd":
    ensure    => running,
    enable    => true,
    require   => Package["httpd"];
  }

  file { "/etc/httpd/conf.d/php-development.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/development/httpd-php.conf",
    require => [ Package["httpd"], Package["php54"] ],
    notify => Service["httpd"]
  }

  file { "/etc/httpd/conf.d/mystuff.conf":
      owner  => root,
      group  => root,
      mode   => 644,
      source => "puppet:///modules/development/mystuff.conf",
      require => [ Package["httpd"]],
      notify => Service["httpd"]
  }


    file { "/etc/pki/tls/certs/ca.crt" :
      owner  => root,
      group  => root,
      mode   => 644,
      source => "puppet:///modules/development/ca.crt",
      require => [ Package["httpd"]],
      notify => Service["httpd"]
    }


    file { "/etc/pki/tls/private/ca.key" :
      owner  => root,
      group  => root,
      mode   => 644,
      source => "puppet:///modules/development/ca.key",
      require => [ Package["httpd"]],
      notify => Service["httpd"]
    }


    file { "/etc/pki/tls/private/ca.csr" :
      owner  => root,
      group  => root,
      mode   => 644,
      source => "puppet:///modules/development/ca.csr",
      require => [ Package["httpd"]],
      notify => Service["httpd"]
    }

    file { "/etc/httpd/conf.d/ssl.conf" :
      owner  => root,
      group  => root,
      mode   => 644,
      source => "puppet:///modules/development/ssl.conf",
      require => [ Package["httpd"]],
      notify => Service["httpd"]
    }




    user { 'vagrant' :
      groups => ['vagrant'],
      require => Package['httpd'],
      notify => Service['httpd'],
  }
  user { 'apache' :
      groups => ['vagrant'],
      require => Package['httpd'],
      notify => Service['httpd'],
  }
 

}