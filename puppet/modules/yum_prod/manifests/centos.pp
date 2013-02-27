class yum_prod::centos {
    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6':
        owner => root,
        group => root,
        mode => 644,
        source => 'puppet:///modules/yum_prod/RPM-GPG-KEY-CentOS-6'
    }

    $disable = [
      '/etc/yum.repos.d/CentOS-Base.repo',
      '/etc/yum.repos.d/CentOS-Debuginfo.repo',
      '/etc/yum.repos.d/CentOS-Media.repo',
      '/etc/yum.repos.d/CentOS-Vault.repo',
    ]

    file { $disable:
        content => "# disabled by puppet\n",
    }

    yumrepo { 'centos-base':
        name => 'centos-base',
        descr => 'CentOS-$releasever - Base',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os',
        failovermethod => priority,
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
        require => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6'],
        exclude => 'mysql-*',
    }

    yumrepo { 'centos-updates':
        name => 'centos-updates',
        descr => 'CentOS-$releasever - Updates',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates',
        failovermethod => priority,
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
        require => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6'],
        exclude => 'mysql-*',
    }
}
