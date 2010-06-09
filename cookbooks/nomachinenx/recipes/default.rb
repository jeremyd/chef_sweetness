#
# Cookbook Name:: nomachinenx
# Recipe:: default
#
# Copyright 2010, Example Com
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

ssh_packages = case node[:platform]
  when "centos","redhat","fedora"
    %w{openssh-clients openssh}
  else
    %w{openssh-client openssh-server}
  end

ssh_packages.each do |pkg|
  package pkg
end

service "ssh" do
  case node[:platform]
  when "centos","redhat","fedora"
    service_name "sshd"
  else
    service_name "ssh"
  end
  supports :restart => true
  action [ :enable ]
end

# if user is $ignore, then skip this step
unless node[:nomachinenx][:user] == ""
  Chef::Log.info "Creating user for nomachine sessions: #{node[:nomachinenx][:user]}"
  user node[:nomachinenx][:user] do
    password node[:nomachinenx][:pass]
  end
end

if node[:platform] == "ubuntu" || node[:platform] == "debian"

  template "/etc/ssh/sshd_config" do
    source "sshd_config.erb"
  end

# Install xorg and gnome (or preferred desktop)
  package "gnome-core"

# Install nomachine debs
  ATTACH_DIR = ::File.join(::File.dirname(__FILE__), "..", "files", "default") 
  if node[:kernel][:machine] == "x86_64"
	  packages = Dir.glob(File.join(ATTACH_DIR, "*x86_64*"))
  else
    packages = Dir.glob(File.join(ATTACH_DIR, "*i386*"))
  end
  Chef::Log.info("node kernel machine was : #{node[:kernel][:machine]}")
  Chef::Log.info packages.join(",")

  client_first = packages.select {|p| p =~ /client/ }
  then_node = packages.select {|p| p =~ /node/ }
  finally_server = packages.select {|p| p =~ /server/ }

  (client_first + then_node + finally_server).each do |p|
    dpkg_package p do
      source p
      action :install
    end
  end

  if node.nomachinenx.ssh_port != "22"
    Chef::Log.info "Configuring NX for non-standard SSH port: #{node.nomachine.ssh_port}"
    template "/usr/NX/etc/node.cfg" do
      source "node.cfg.erb"
    end
    template "/usr/NX/etc/server.cfg" do
      source "server.cfg.erb"
    end
  end
end

