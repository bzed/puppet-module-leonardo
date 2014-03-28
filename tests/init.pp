# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation errors
# and view a log of events) or by fully applying the test in a virtual environment
# (to compare the resulting system state to the desired state).
#
# Learn more about module testing here: http://docs.puppetlabs.com/guides/tests_smoke.html
#
$install_dir = '/var/www/leonardo'

class { 'leonardo':
  graphite_url => 'https://graphite.example.org',
  template_dir => '/var/www/leonardo/graphs',
  install_dir  => $install_dir,
}

class { '::apache':
  default_vhost => false,
}

include ::apache::mod::wsgi

apache::vhost { "leonardo.${::domain}":
  port                        => '80',
  docroot                     => $install_dir,
  wsgi_script_aliases         => { '/' => "${install_dir}/leonardo.wsgi" },
  wsgi_daemon_process         => 'wsgi',
  wsgi_daemon_process_options => {
    threads => '5',
    user    => 'leonardo'
  },
}
