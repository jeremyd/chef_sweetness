#
# Cookbook Name:: books_refresh
# Recipe:: default
#
require 'chef-deploy'
require 'fileutils'

directory File.join(node[:books_refresh][:chef_home],"chef-deploy") do
  recursive true
  action :create
  mode 0755
end

deploy File.join(node[:books_refresh][:chef_home],"chef-deploy") do
  repo node[:books_refresh][:git_repo]
  enable_submodules false
  shallow_clone true
  action :deploy
  user "root"
  group "wheel"
end

FileUtils.rm_rf(File.join(node[:books_refresh][:chef_home],"cookbooks"))

link File.join(node[:books_refresh][:chef_home],"cookbooks") do
  to File.join(node[:books_refresh][:chef_home],"chef-deploy","current",node[:books_refresh][:target_subdir])
end
