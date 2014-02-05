define leonardo::properties (
  $target,
  $properties = [],
) {

  each($parameters) |$key, $value| {
    yaml_setting { "${name}-${key}":
      target => $target,
      key    => $key,
      value  => $value,
    }
  }


}
