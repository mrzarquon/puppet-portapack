class portapack::classroom (
  $studentarray,
  $customer   = 'tse_demo',
  $department = 'TSE',
  $linux_ami  = 'ami-e08efbd0', 
  $linux_type = 't2.medium',
  $win_ami    = 'ami-21f0bc11'
  $win_type   = 't2.medium',
  $vpcid      = 'subnet-8f3df3ea',
  $securityid = 'cbarker_awsdemo',
  $ssh_key    = 'chrisbarker_pl_west2',
  $region     = 'us-west-2',
  $pe_master  = "${::servername}",
  $pe_version_string = "${::pe_version}",
) {


  Portapack::Vms {
    customer          => $customer,
    department        => $department,
    linux_ami         => $linux_ami,
    linux_type        => $linux_type,
    win_ami           => $win_ami,
    win_type          => $win_type,
    vpcid             => $vpcid,
    securityid        => $securityid,
    ssh_key           => $ssh_key,
    region            => $region,
    pe_master         => $pe_master,
    pe_version_string => $pe_version_string,
  }



}
