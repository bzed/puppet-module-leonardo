#
#   Copyright 2014 Portland State University
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
class leonardo(
  $graphite_url,
  $template_dir,
  $graphite_username = undef,
  $graphite_password = undef,
  $install_dir = '/var/www/leonardo',
) {

  include leonardo::web::apache

  package { 'python-pip':
    ensure => present,
  }

  package { 'flask':
    provider => pip,
    ensure   => present,
    require  => Package['python-pip'],
  }

  package { 'pyyaml':
    ensure   => present,
    provider => pip,
    require  => Package['python-pip'],
  }

  user { 'leonardo':
    ensure     => present,
    managehome => true,
  }

  vcsrepo { $install_dir:
    ensure   => present,
    provider => git,
    source   => 'git://github.com/PrFalken/leonardo.git',
    require  => User['leonardo'],
  }

  file { "${install_dir}/leonardo.wsgi":
    ensure  => present,
    mode    => '0644',
    content => template('leonardo/leonardo.wsgi.erb'),
    require => Vcsrepo[$install_dir]
  }

  file { "${install_dir}/config/leonardo.yaml":
    ensure  => present,
    mode    => '0644',
    content => template('leonardo/leonardo.yaml.erb'),
    require => Vcsrepo[$install_dir]
  }


}

