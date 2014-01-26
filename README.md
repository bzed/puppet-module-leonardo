Leonardo Puppet module
======================

Leonardo is a Dashboard for Graphite written by [PrFalken](https://github.com/PrFalken)

https://github.com/PrFalken/leonardo

Usage
-----

```puppet
class { 'leonardo':
  graphite_url => 'graphite.example.com',
  template_dir => '/var/www/leonardo/graphs',
}
```

Known Issues
------------

* The module currently has an issue with Apache/WSGI unable to find the leonado/config.yaml, the workaround is to hardcode the absolute path in leonardo/config.py

