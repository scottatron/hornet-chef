#
# Cookbook Name:: hornet
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "git"

package "libsqlite3-dev"
package "imagemagick"

include_recipe "sudo"
