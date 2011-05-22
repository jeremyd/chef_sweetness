log "user was #{node.box.user}"
user node.box.user do
  home "/home/#{node.box.user}"
  shell "/bin/bash"
end
directory "/home/#{node.box.user}" do
  recursive true
  mode "0700"
  owner node.box.user
  group node.box.user
end
directory "/home/#{node.box.user}/skyped" do
  recursive true
  owner node.box.user
  group node.box.user
end
template "/home/#{node.box.user}/skyped/skyped.conf" do
  source "skyped.conf.erb"
  owner node.box.user
  group node.box.user
end
template "/home/#{node.box.user}/skyped/skyped.cnf" do
  source "skyped.cnf.erb"
  owner node.box.user
  group node.box.user
end
directory "/home/#{node.box.user}/bin" do
  recursive true
  owner node.box.user
  group node.box.user
end
directory "/home/#{node.box.user}/.ssh" do
  recursive true
  owner node.box.user
  group node.box.user
end
template "/home/#{node.box.user}/.ssh/authorized_keys" do
  source "authorized_keys.erb"
  mode "0600"
end
template "/home/#{node.box.user}/bin/xvfb-run-start.sh" do
  source "xvfb-run-start.sh.erb"
  mode "0755"
  owner node.box.user
  group node.box.user
end
template "/home/#{node.box.user}/bin/x11vnc-start.sh" do
  source "x11vnc-start.sh.erb"
  mode "0755"
  owner node.box.user
  group node.box.user
end
template "/home/#{node.box.user}/bin/auto-cert-gen.sh" do
  source "auto-cert-gen.sh.erb"
  mode "0755"
  owner node.box.user
  group node.box.user
end
template "/home/#{node.box.user}/bin/skyped-start.sh" do
  source "skyped-start.sh.erb"
  mode "0755"
  owner node.box.user
  group node.box.user
end
template "/home/#{node.box.user}/.monitrc" do
  source ".monitrc.erb"
  mode "0600"
  owner node.box.user
  group node.box.user
end
bash "run skype openssl cert generation using expect script" do
  #not_if "test -f /home/#{node.box.user}/skyped/skyped.key.pem"
  user node.box.user 
  group node.box.user
  code "/home/#{node.box.user}/bin/auto-cert-gen.sh"
end
bash "run xvfb" do
  not_if "test -f /home/#{node.box.user}/Xvfb.pid"
  environment "HOME" => "/home/#{node.box.user}"
  user node.box.user
  group node.box.user
  code "/home/#{node.box.user}/bin/xvfb-run-start.sh start"
end
#ruby_block "sleep for x11vnc" do
#  block do sleep 5 end
#end
bash "run x11vnc" do
  environment "HOME" => "/home/#{node.box.user}"
  user node.box.user
  group node.box.user
  code "/home/#{node.box.user}/bin/x11vnc-start.sh"
end
#bash "run skyped" do
#  environment "HOME" => "/home/#{node.box.user}", "DISPLAY" => ":0"
#  user node.box.user
#  group node.box.user
#  code "/home/#{node.box.user}/bin/skyped-start.sh"
#end
bash "run monit (skyped)" do
  environment "HOME" => "/home/#{node.box.user}"
  user node.box.user
  group node.box.user
  code "/usr/sbin/monit -l /home/jeremy/monit.log"
end
