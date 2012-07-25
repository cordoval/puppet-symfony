class dev {
    package { 'curl':
        ensure => installed
    }
    package { 'git':
        ensure => installed
    }
}
