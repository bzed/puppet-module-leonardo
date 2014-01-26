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
class leonardo::web::apache {

  class { '::apache':
    default_vhost => false,
  }

  include ::apache::mod::wsgi

  apache::vhost { "metrics.$domain":
    port                        => '80',
    docroot                     => $leonardo::install_dir,
    wsgi_script_aliases         => { '/' => "${leonardo::install_dir}/leonardo.wsgi" },
    wsgi_daemon_process         => 'wsgi',
    wsgi_daemon_process_options => {
      threads => '5',
      user    => 'leonardo'
    },
  }
}
