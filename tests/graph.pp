leonardo::graph { 'cpu':
  target     => '/tmp/foo.graph',
  parameters => { 'title'    => 'CPU graph',
               'vtitle'   => 'percent',
               'linemode' => 'connected' },
  fields     => { 'data' => "sumSeries(collectd.${::hostname}.cpu*.cpu-system)" ,
                  'cacti_style' => 'true',
                }
}
