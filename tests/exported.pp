# Example configs for using exported resources
# look at collector.pp to collect them.

  $dashboard_root = '/tmp/graphs',
  $collectd_name  = regsubst($::fqdn, '\.', '_', 'G'),
  $dashboard_dir  = "${dashboard_root}/${::hostname}",

  # Each host needs a directory to hold the graph files
  @@file { $dashboard_dir:
    ensure => directory,
    mode   => '0755',
    tag    => "env_leonardo_${environment}",
  }

  # Export a dash.yaml file
  @@leonardo::dashboard { $::hostname:
    target             => "${dashboard_dir}/dash.yaml",
    name               => $::hostname,
    description        => 'System Metrics',
    include_properties => ['common.yaml'],
    tag                => "env_${environment}",
    require            => File[$dashboard_dir],
  }

  # Export a cpu graph
  @@leonardo::graph { "${::hostname}-cpu":
    target     => "${dashboard_dir}/10-cpu.graph",
    parameters => { 'title'  => 'Combined CPU Usage',
                    'vtitle' => 'percent',
                    'area'   => 'stacked' },
    fields     => {
                    'iowait' => { 'data' => "sumSeries(collectd.${collectd_name}.cpu*.cpu-wait)",},
                    'system' => { 'data' => "sumSeries(collectd.${collectd_name}.cpu*.cpu-system)",},
                    'user'   => { 'data' => "sumSeries(collectd.${collectd_name}.cpu*.cpu-user)",},
                  },
    tag       => "env_${environment}",
    require   => File[$dashboard_dir],
  }

  # Export a load graph
  @@leonardo::graph { "${::hostname}-load":
    target     => "${dashboard_dir}/20-load.graph",
    parameters => { 'title'  => 'Load Average',
                    'vtitle' => 'Load',
                    'area'   => 'first' },
    fields     => {
                    'shortterm'  => { 'data' => "sumSeries(collectd.${collectd_name}.load.load.shortterm)",},
                    'midterm'    => { 'data' => "sumSeries(collectd.${collectd_name}.load.load.midterm)",},
                    'longterm'   => { 'data' => "sumSeries(collectd.${collectd_name}.load.load.longterm)",},
                  },
    tag       => "env_${environment}",
    require   => File[$dashboard_dir],
  }

  # Export a memory graph
  @@leonardo::graph { "${::hostname}-memory":
    target     => "${dashboard_dir}/30-memory.graph",
    parameters => { 'title'  => 'Memory Usage',
                    'vtitle' => 'Bytes',
                    'area'   => 'stacked' },
    fields     => {
                    'used'   => { 'data' => "sumSeries(collectd.${collectd_name}.memory.memory-used)",},
                    'bufferd'=> { 'data' => "sumSeries(collectd.${collectd_name}.memory.memory-buffered)",},
                    'cached' => { 'data' => "sumSeries(collectd.${collectd_name}.memory.memory-cached)",},
                    'free'   => { 'data' => "sumSeries(collectd.${collectd_name}.memory.memory-free)",},
                  },
    tag       => "env_${environment}",
    require   => File[$dashboard_dir],
  }
