include_recipe 'hornet::ruby'
include_recipe 'mysql::server'
include_recipe 'redis::default'
package 'imagemagick'
