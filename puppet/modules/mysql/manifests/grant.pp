define mysql::grant ($database = $title, $user, $password = false) {

  if $password {
    $grant_password = $password
  } else {
    $grant_password = $user
  }

  exec { "grant-db-${database}-${user}":
    unless  => "/usr/bin/mysql --user=$user --password=$grant_password $database",
    command => "/usr/bin/mysql -e \"
               grant all privileges on $database.* to $user identified by '$grant_password';
               grant all privileges on $database.* to $user@'localhost' identified by '$grant_password';
               grant all privileges on $database.* to $user@'%' identified by '$grant_password';
               flush privileges;\"",
    require => [Service['mysqld']],
  }
}

