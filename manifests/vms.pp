define portapack::vms (
  $name       = $title,
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

  Ec2_instance {
    ensure          => present,
    region          => $region,
    monitoring      => true,
    key_name        => $ssh_key,
    subnet          => $vpcid,
    security_groups => $security_id,
    tags            => {
      department    => $department,
      customer      => $customer,
    },
  }

  ec2_instance { "${name}-win":
    image_id      => $win_ami,
    instance_type => $win_type,
    user_data     => template('portapack/windows-pe-agent.erb'),
  }

  ec2_instance { "${name}-linux":
    image_id      => $linux_ami,
    instance_type => $linux_type,
    user_data     => template('portapack/linux-pe-agent.erb'),
  }
}
