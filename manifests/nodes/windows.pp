class portapack::nodes::windows (
  $student,
) {
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
