define leonardo::properties (
  $target,
  $properties = {},
) {

  each($properties) |$key, $value| {
    yaml_setting { "${name}-${key}":
      target => $target,
      key    => "graph_properties/${key}",
      value  => $value,
    }
  }


}
