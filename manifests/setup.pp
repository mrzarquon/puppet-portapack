class portapack::setup {

  package { 'puppetdbquery':
    ensure   => present,
    provider => 'pe_gem',
  }

}
