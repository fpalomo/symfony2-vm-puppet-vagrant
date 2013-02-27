class yum_prod::ius {
    file { "/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY":
        owner => root,
        group => root,
        mode => 644,
        source => "puppet:///modules/yum_prod/IUS-COMMUNITY-GPG-KEY"
    }

    yumrepo { "ius":
        name => "ius",
        descr => 'IUS Community Packages for Enterprise Linux 6 - $basearch',
        mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-el6&arch=$basearch',
        # baseurl => 'http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/$basearch',
        failovermethod => priority,
        enabled => 1,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY",
        require => File["/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY"],
    }
}