Leonardo Puppet module
======================

Leonardo is a Dashboard for Graphite written by [PrFalken](https://github.com/PrFalken)

https://github.com/PrFalken/leonardo

Warning
-------

Currently, this module depends on the experimental `each` function from Puppet's future parser.

Usage
-----

```puppet
class { 'leonardo':
  graphite_url => 'graphite.example.com',
  template_dir => '/var/www/leonardo/graphs',
}
```

### leonardo::dashboard

```puppet
leonardo::dashboard { $::hostname:
  target             => '/path/to/dash.yaml',
  name               => $::hostname,
  description        => 'System Metrics',
  include_properties => ['common.yaml'],
}
```

### leonardo::graph
```puppet
leonardo::graph { 'cpu':
  target     =>  '/path/to/cpu.graph',
  parameters => { 'title'  => 'Combined CPU Usage',
                  'vtitle' => 'percent',
                  'area'   => 'stacked' },
  fields     => {
                  'iowait' => { 'data'        => "sumSeries(collectd.${::hostname}.cpu*.cpu-wait)",
                                'cacti_style' => 'true',},
                  'system' => { 'data'        => "sumSeries(collectd.${::hostname}.cpu*.cpu-system)",
                                'cacti_style' => 'true',},
                  'user'   => { 'data'        => "sumSeries(collectd.${::hostname}.cpu*.cpu-user)",
                                'cacti_style' => 'true',},
                },
```

### leonardo::properties

```puppet
leonardo::properties { 'common.yaml':
  target     => '/path/to/common.yaml',
  properties => { 'linewidth'       => '0.8',
                  'area_alpha'      => '0.7',
                  'timezone'        => 'America/Los_Angeles',
                  'hide_legend'     => 'false',
                  'field_linewidth' => '2', },
}
```


Known Issues
------------

* The module currently has an issue with Apache/WSGI unable to find the leonado/config.yaml, the workaround is to hardcode the absolute path in leonardo/config.py

