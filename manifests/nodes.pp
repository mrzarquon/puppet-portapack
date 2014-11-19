class portapack::nodes (
  $student = 'studentname',
) {

  include win_rdp

  file { 'c:\programdata\puppetlabs\facter\facts.d\guac.txt':
    content => "studentname=${student}",
  }

  user { 'student':
    ensure   => present,
    groups   => ['Administrators', 'Users'],
    password => 'P4ssW0rd!',
  }

}
