
leonardo::dashboard { 'server1':
  target             => '/tmp/dash.yaml',
  description        => 'SystemMetrics',
  include_properties => ['common.yaml', 'foo.yaml'],
}
