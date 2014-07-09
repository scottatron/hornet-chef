include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby node.hornet.ruby.version do
  global true
end

rbenv_gem "bundler" do
  ruby_version node.hornet.ruby.version
end

rbenv_execute "gem update --system"
rbenv_execute "gem pristine --all"
