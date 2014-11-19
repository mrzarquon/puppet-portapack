class portapack::guac inherits portapack {

  $students = $portapack::studentarray

  Package {
    require => Class['apt'],
    before  => File['/etc/guacamole/guacamole.properties'],
  }

  class { 'apt':
    always_apt_update => always,
  }

  package { [
    'guacamole-tomcat',
    'libguac-client-ssh0',
    'libguac-client-rdp0' ] :
    ensure => present,
  }

  file { '/etc/guacamole/guacamole.properties':
    ensure => file,
    owner  => 'tomcat6',
    group  => 'guacamole-web',
    mode   => '0644',
  }

  file { '/etc/guacamole/user-mapping.xml':
    ensure  => file,
    content => template('portapack/user-mapping.erb'),
    notify  => Service['tomcat6'],
  }

  service { 'tomcat6':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/guacamole/guacamole.properties'],
  }

  Host <<| |>>

}
