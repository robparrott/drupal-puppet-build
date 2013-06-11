node default {

  include stdlib
                                                                                                                                                                             
  class { 'mysql::server': }
  class { 'mysql::php':    }
  
  class { 'apache':}
  class { 'apache::mod::ssl': }
  class { 'apache::mod::php': }

  class { 'memcached': }

  apache::vhost { $fqdn:
    vhost_name => $fqdn,
    port => 8080,
    docroot => '/var/www/drupal'
  }
  
    
 class { 'varnish':
    vcl_content => template('default.vcl.erb')
  }

  include drupal
  drupal::core { '7.21':
    path => '/var/www/drupal',
  }
  
#  class { 'drush': }
  class { 'drupal': }
  

}