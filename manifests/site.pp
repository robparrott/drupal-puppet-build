node default {

  include stdlib
           
  class { ''}                                                                                                                                                                   
  class { 'mysql::server': }
  class { 'mysql::php':    }
  
  class { 'apache':}
  class { 'apache::mod::ssl': }
  class { 'apache::mod::php': }

  apache::vhost { $fqdn:
    vhost_name => $fqdn,
    port => 80,
    docroot => '/var/www/wordpress'
  }
  
 class { 'varnish':
    vcl_content => template('myapp/myvcl.erb')
  }
  


}