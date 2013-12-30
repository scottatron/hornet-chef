include_recipe "gitlab-ci::runner"
include_recipe "phantomjs"

# Add gitlab to sudo group for passwordless sudo
group "sudo" do
  action :modify
  members "gitlab"
  append true
end

cookbook_file "/home/gitlab/.ssh/deploy_key" do
  owner "gitlab"
  group "gitlab"
  mode 0600
end

cookbook_file "/home/gitlab/.ssh/deploy_key.pub" do
  owner "gitlab"
  group "gitlab"
  mode 0644
end

ssh_config "github.com" do
  options 'User' => 'git', 'IdentityFile' => '/home/gitlab/.ssh/deploy_key'
  user "gitlab"
end

ssh_known_hosts "github.com" do
  user "gitlab"
  hashed false
end

ssh_config "gitlab.com" do
  options 'User' => 'git', 'IdentityFile' => '/home/gitlab/.ssh/deploy_key'
  user "gitlab"
end

ssh_known_hosts "gitlab.com" do
  user "gitlab"
  hashed false
end

git "hornet" do
  repository   "git@github.com:scottatron/hornet-r3.git"
  reference    "r32"
  destination  "/home/gitlab/hornet"
  user         "gitlab"
  group        "gitlab"
  action       :sync
end

bash "bundle install" do
  code "bundle install --path /home/gitlab/.bundle"
  cwd "/home/gitlab/hornet"
  user "gitlab"
end

require 'yaml'
database_yaml = { 
  'test' => { 
    'adapter' => 'mysql2', 
    'encoding' => 'utf8', 
    'database' => 'hornet_test', 
    'pool' => 5, 
    'username' => 'root', 
    'password' => 'root' 
  } 
}.to_yaml

file "/home/gitlab/hornet/config/database.yml" do
  content database_yaml
  owner "gitlab"
  group "gitlab"
  mode 0644
end

directory "/home/gitlab/larvae" do
  owner "gitlab"
  group "gitlab"
  mode 0755
end

directory "/home/gitlab/larvae-modules" do
  owner "gitlab"
  group "gitlab"
  mode 0755
end

file "/home/gitlab/hornet/.hornetrc" do
  content <<-DOC
LARVAE_PATH=/home/gitlab/larvae
MODULES_PATH=/home/gitlab/larvae-modules
DOC
  owner "gitlab"
  group "gitlab"
  mode 0644
end

bash "Create tmp and seed_database" do
  code "RAILS_ENV=test bundle exec rake tmp:create db:setup"
  cwd "/home/gitlab/hornet"
  user "gitlab"
end

