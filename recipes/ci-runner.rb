include_recipe "gitlab-ci::runner"

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

git "gitlab-ci-runner" do
  repository   "git@github.com:scottatron/hornet-r3.git"
  destination  "/home/gitlab/hornet"
  user         "gitlab"
  group        "gitlab"
  action       :sync
end
