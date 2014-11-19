class portapack::nodes (
  $student = 'studentname',
) {

  case $::kernel {
    'windows': {
      include win_rdp

      file { 'c:\programdata\puppetlabs\facter\facts.d\guac.txt':
        content => "studentname=${student}",
      }

      user { $student:
        ensure   => present,
        groups   => ['Administrators', 'Users'],
        password => 'P4ssW0rd!',
      }

      @@host { "${student}-win":
        ip => $::ipaddress,
      }
    }
    'linux': {

      @@host { "${student}-linux":
        ip => $::ipaddress_eth1,
      }

      user { $student:
        ensure     => present,
        password   => '$1$oWCSltQ0$vnDr0jk.4DtR8N4iYXKbM0',
        managehome => true,
      }

      ssh_authorized_key { 'really_insecure_key@puppetlabs.com':
        user    => $student,
        type    => 'ssh-rsa',
        key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC0KvgeiOT1kWvfP8FrzDi3W3QuQinesu//h+MA9Omxx9EF38hX1aHX8XQk79jAxrRkKMyUq/h45ATxv2Qbr83uW1qZ9tSD//8FeRw0V5oilOhQHRQKL4EVK2BG5yR0k2Td19ptPCXvBOQ2YMJg7aLC4im6smAVrwyQcMnYWfR8uneof4GQhwNjU0cmZPb1J5dXS2kYYTcv1mmxe+d7EXkbh1ms+1wIDyvZWYsaYPrVgVeznHKD5I56a67AeFhccShn4rkDIATL1UNmfnZSg5QOLKyYmTxSmvov0maR2/zn7SKf5j7E1kq+kJ+xTcd5ooRRUBrYGsEsTAW8kQlJRAEB',
        require => User[$student],
      }
    }
  }
}
