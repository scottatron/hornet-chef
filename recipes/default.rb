include_recipe 'apt'
include_recipe 'hornet::ruby'
include_recipe 'mysql::server'
include_recipe 'hornet::redis'
package 'imagemagick'
package 'nodejs'
