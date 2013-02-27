class yum_prod::epel {
    file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6":
        owner => root,
        group => root,
        mode => 644,
        source => "puppet:///modules/yum_prod/RPM-GPG-KEY-EPEL-6"
    }

    yumrepo { "epel":
        name => "epel",
        descr => 'Extra Packages for Enterprise Linux 6 - $basearch',
        mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
        # baseurl => 'http://download.fedoraproject.org/pub/epel/6/$basearch',
        failovermethod => priority,
        enabled => 1,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6",
        require => File["/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6"],
    }
}