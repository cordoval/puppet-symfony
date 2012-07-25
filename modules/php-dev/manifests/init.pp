class php::install-dev {
    package { 'php5-xdebug':
        ensure => installed,
        require => Class['php::install-cli']
    }
    exec { 'pear-auto-discover':
        path => '/usr/bin:/usr/sbin:/bin',
        # onlyif => 'test "`pear config-get auto_discover`" = "0"',
        command => 'pear config-set auto_discover 1 system;',
        require => Class['php::install-cli']
    }
    exec { 'pear-update':
        path => '/usr/bin:/usr/sbin:/bin',
        command => 'pear update-channels && pear upgrade-all',
        require => Class['php::install-cli']
    }
    exec { 'install-phpunit':
        unless => "/usr/bin/which phpunit",
        command => '/usr/bin/pear install pear.phpunit.de/PHPUnit --alldeps',
        require => [Class['php::install-cli'], Exec['pear-auto-discover'], Exec['pear-update']]
    }
    exec { 'install-phpqatools':
        unless => "/usr/bin/which phpcs",
        command => "/usr/bin/pear install pear.phpqatools.org/phpqatools --alldeps",
        require => [Class['php::install-cli'], Exec['pear-auto-discover'], Exec['pear-update']]
    }
}

class php-dev {
    include php::install-dev
}
