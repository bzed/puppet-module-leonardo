
file { '/tmp/graphs':
  ensure => 'directory',
}

$dashboard_dir = "/tmp/graphs/$::hostname"

file { $dashboard_dir:
  ensure  => 'directory',
  require => File['/tmp/graphs'],
}


leonardo::dashboard { $::hostname:
  target             => "${dashboard_dir}/dash.yaml",
  name               => $::hostname,
  description        => 'System Metrics',
  include_properties => ['common.yaml'],
  require            => File[$dashboard_dir],
}

leonardo::graph { 'cpu':
  target     => "${dashboard_dir}/${name}.graph",
  parameters => { 'title'       => 'Combined CPU Usage',
                  'vtitle'      => 'percent',
                  'area'        => 'stacked' },
  fields     => {
                  'iowait' => { 'data' => "sumSeries(collectd.${::hostname}.cpu*.cpu-wait)",
                                'cacti_style' => 'true',},
                  'system' => { 'data' => "sumSeries(collectd.${::hostname}.cpu*.cpu-system)",
                                'cacti_style' => 'true',},
                  'user' => { 'data' => "sumSeries(collectd.${::hostname}.cpu*.cpu-user)",
                                'cacti_style' => 'true',},
                },
  require    => File[$dashboard_dir],
}


