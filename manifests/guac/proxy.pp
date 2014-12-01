# This class sets up the apache proxy for Guac
# allowing us to keep using the standard guac 
# tomcat instance, but serve on port 80 or 443

class portapack::guac::proxy (
) {

  include apache
  include apache::mod::proxy
  include apache::mod::proxy_ajp

  file { '/etc/guacamole/public.key':
    ensure => file,
    owner  => 'www-data',
    group  => 'guacamole-web',
    mode   => '750',
    source => "/etc/puppetlabs/puppet/ssl/certs/${::ec2_instance_id}.pem",
    before => Apache::Vhost ["${::ec2_public_hostname}"],
  }
  file { '/etc/guacamole/private.key':
    ensure => file,
    owner  => 'www-data',
    group  => 'guacamole-web',
    mode   => '750',
    source => "/etc/puppetlabs/puppet/ssl/private_keys/${::ec2_instance_id}.pem",
    before => Apache::Vhost ["${::ec2_public_hostname}"],
  }

  apache::vhost { "${::ec2_public_hostname}":
    port            => '443',
    docroot         => '/var/www/',
    ssl             => true,
    ssl_cert        => '/etc/guacamole/public.key',
    ssl_key         => '/etc/guacamole/private.key',
    proxy_pass      => [ {
      'path'        => "/guacamole",
      'url'         => "ajp://localhost:8009/guacamole",
      'reverse_url' => "https://${::ec2_public_hostname}/guacamole",
    } ],
  }

}
