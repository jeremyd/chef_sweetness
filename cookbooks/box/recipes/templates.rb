log "user was #{node.box.user}"
if node.box.user == "root"
  users_home = "/root"
else
  users_home = "/home/#{node.box.user}"
end
unless node.box.user == 'root'
  user node.box.user do
    home users_home
    shell "/bin/bash"
  end
  directory users_home do
    recursive true
    mode "0700"
    owner node.box.user
    group node.box.user
  end
end
directory "#{users_home}/skyped" do
  recursive true
  owner node.box.user
  group node.box.user
end
template "#{users_home}/skyped/skyped.conf" do
  source "skyped.conf.erb"
  owner node.box.user
  group node.box.user
  variables(:users_home => users_home)
end
template "#{users_home}/skyped/skyped.cnf" do
  source "skyped.cnf.erb"
  owner node.box.user
  group node.box.user
  variables(:users_home => users_home)
end
directory "#{users_home}/bin" do
  recursive true
  owner node.box.user
  group node.box.user
end
directory "#{users_home}/.ssh" do
  recursive true
  owner node.box.user
  group node.box.user
end
template "#{users_home}/.ssh/authorized_keys" do
  not_if "test -f #{users_home}/.ssh/authorized_keys"
  source "authorized_keys.erb"
  mode "0600"
end
template "#{users_home}/bin/xvfb-run-start.sh" do
  source "xvfb-run-start.sh.erb"
  mode "0755"
  owner node.box.user
  group node.box.user
end
template "#{users_home}/bin/x11vnc-start.sh" do
  source "x11vnc-start.sh.erb"
  mode "0755"
  owner node.box.user
  group node.box.user
end
template "#{users_home}/bin/auto-cert-gen.sh" do
  source "auto-cert-gen.sh.erb"
  mode "0755"
  owner node.box.user
  group node.box.user
  variables(:users_home => users_home)
end
template "#{users_home}/bin/skyped-start.sh" do
  source "skyped-start.sh.erb"
  mode "0755"
  owner node.box.user
  group node.box.user
  variables(:users_home => users_home)
end
template "#{users_home}/.monitrc" do
  source ".monitrc.erb"
  mode "0600"
  owner node.box.user
  group node.box.user
  variables(:users_home => users_home)
end
bash "run skype openssl cert generation using expect script" do
  #not_if "test -f /home/#{node.box.user}/skyped/skyped.key.pem"
  user node.box.user 
  group node.box.user
  code "#{users_home}/bin/auto-cert-gen.sh"
end
service "dbus" do
  action :start
end
if node.box.startup == "true"
  bash "run xvfb" do
    not_if "test -f #{users_home}/Xvfb.pid"
    environment "HOME" => users_home, "USER" => node.box.user, "TERM" => "xterm", "SHELL" => "/bin/bash"
    user node.box.user
    group node.box.user
    code "#{users_home}/bin/xvfb-run-start.sh start"
  end
  bash "run x11vnc" do
    not_if "test -f #{users_home}/x11vnc.pid"
    environment "HOME" => users_home
    user node.box.user
    group node.box.user
    code "#{users_home}/bin/x11vnc-start.sh"
  end
  bash "run monit (skyped)" do
    environment "HOME" => users_home 
    user node.box.user
    group node.box.user
    code "/usr/sbin/monit -l #{users_home}/monit.log"
  end
end
