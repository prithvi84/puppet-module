class nginx {
    $nginx_package = $::operatingsystem ? {
        Fedora  => 'nginx',
        Ubuntu => 'nginx',
    }
    $nginx_config_path = $::operatingsystem ? {
        Fedora  => '/etc/nginx/conf.d/default.conf',
	CentOS  => '/etc/nginx/conf.d/default.conf',
	RedHat  => '/etc/nginx/conf.d/default.conf',
        Ubuntu => '/etc/nginx/sites-enabled/default',
    }
    $nginx_service = $::operatingsystem ? {
        Fedora  => 'nginx',
        Ubuntu => 'nginx',
    }
    package { $nginx_package:
    ensure => installed,
  }
    file { '/var/www':
    ensure => 'directory',
    owner => root,
    group => root,
    mode => 755,
 }
    file { '/etc/nginx/certs':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    require => Package['nginx'],
  }
    file { '/var/www/html':
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    mode => '0755',
    require => File['/var/www'],
  }
    file { '/var/www/html/index.html':
    owner => 'root',
    group => 'root',
    mode => '0755',
    source => 'puppet:///modules/nginx/index.html',
    require => [ File['/var/www/html'], File['/var/www'] ]
  }
    file { '/etc/nginx/certs/mysitename.pem':
    source => 'puppet:///modules/nginx/mysitename.crt',
  }
    file { '/etc/nginx/certs/mysitename_key.pem':
    source => 'puppet:///modules/nginx/mysitename.key',
  }
    service { 'nginx':
    ensure => running,
    require => Package['nginx'],
  }
    file { $nginx_config_path:
    source => 'puppet:///modules/nginx/default.conf',
    notify => Service['nginx'],
  }
}

