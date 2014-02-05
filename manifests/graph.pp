define leonardo::graph (
  $target,
  $fields     = {},
  $parameters = {},
) {

  each($parameters) |$key, $value| {
    yaml_setting { "${name}-${key}":
      target => $target,
      key    => $key,
      value  => $value,
    }
  }

  each($fields) |$key, $items| {

    each($items) |$item_key, $item_value| {
      yaml_setting { "${name}-fields-${key}-${item_key}":
        target => $target,
        key    => "fields/${key}/${item_key}",
        value  => $item_value,
      }
    }

  }

}

