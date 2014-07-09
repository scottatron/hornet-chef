include_recipe "sudo"

ohai "reload_passwd" do
  action :nothing
  plugin "etc"
end

user "captain" do
  home    "/home/captain"
  shell   "/bin/bash"
  supports manage_home: true
  notifies :reload, "ohai[reload_passwd]", :immediately
end

directory "/home/captain/.ssh" do
  owner "captain"
  group "captain"
  mode 0700
end

file "/home/captain/.ssh/authorized_keys" do
  owner "captain"
  group "captain"
  mode 0600
end

cookbook_file "/home/captain/.ssh/deploy_key" do
  owner "captain"
  group "captain"
  mode 0600
end

cookbook_file "/home/captain/.ssh/deploy_key.pub" do
  owner "captain"
  group "captain"
  mode 0644
end

ssh_config "github.com" do
  options 'User' => 'git', 'IdentityFile' => '/home/captain/.ssh/deploy_key'
  user "captain"
end

ssh_known_hosts "github.com" do
  user "captain"
  hashed false
end

ssh_config "gitlab.com" do
  options 'User' => 'git', 'IdentityFile' => '/home/captain/.ssh/deploy_key'
  user "captain"
end

ssh_known_hosts "gitlab.com" do
  user "captain"
  hashed false
end

ssh_config "git.decent.io" do
  options 'User' => 'git', 'IdentityFile' => '/home/captain/.ssh/deploy_key'
  user "captain"
end

ssh_known_hosts "git.decent.io" do
  user "captain"
  hashed false
end

# Passwordless sudo
sudo 'captain' do
  nopasswd true
  user 'captain'
end
