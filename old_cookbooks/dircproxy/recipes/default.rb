#
# Cookbook Name:: dircproxy
# Recipe:: default
#
# Copyright 2009, Example Com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

remote_file "/tmp/#{@node[:dircproxy][:source]}" do
  source node[:dircproxy][:source]
end

bash "install dircproxy from source" do
#    user "root"
  dirname = node[:dircproxy][:source].gsub(/\.tar\.gz/,"")
  cwd "/tmp"
  code <<-EOH 
  tar -zvxf #{node[:dircproxy][:source]}
  cd #{dirname}
  ./configure
  make
  make install
  EOH
end

user "dircproxy" do
  username "dircproxy"
  home "/home/dircproxy"
  shell "/bin/true"
end

directory "/home/#{@node[:dircproxy][:switch_user]}" do
  mode 0744
  owner "dircproxy"
end

my_conf = "/home/#{@node[:dircproxy][:switch_user]}/.dircproxyrc"
template my_conf do
  source "dircproxy.conf.erb"
  mode 400
  owner @node[:dircproxy][:switch_user]
  group @node[:dircproxy][:switch_user]
end  

execute "start dircproxy" do
  command "dircproxy -f #{my_conf}"
  user "dircproxy"
end
