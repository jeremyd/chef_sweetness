#!/usr/bin/ruby
require 'fileutils'

# Install & configure Chef-solo
# Ignore this section unless you want to change the version of chef.
# required packages: base-devel, ruby, ruby-docs

if `gem list|grep chef`.empty?
  puts `gem install mkrf --no-rdoc --no-ri`
  puts `gem install chef --no-rdoc --no-ri`
end
gempath = `gem env`.split(/\n/).grep(/EXECUTABLE DIRECTORY/).first.split(/:/).last.chomp
solo = File.join(gempath, "chef-solo")
solo_config =<<EOSOLO
file_cache_path "/root/chef-solo"
cookbook_path "/root/chef-solo/cookbooks"
EOSOLO
File.open("/root/chef-solo.conf", "w") { |f| f.write solo_config }

#
#  This is the cookbook (the meat).  
#  Many customization options are available!!!
cookbook =<<EOBOOK
  packages = ["x11vnc"]
  packages.each do |p|
    package p
  end
  user "deleteme" do
    action :create
    home "/home/deleteme"
  end
EOBOOK

#
# End Cookbook Section
#

#
# More un-interesting running of chef-solo.
#
FileUtils.mkdir_p("/root/chef-solo/cookbooks/try/recipes")
File.open("/root/chef-solo/cookbooks/try/recipes/me.rb", "w") { |f| f.write cookbook }
runlist = '{ "run_list": ["try::me", "myl33tbox::default"] }'
File.open("/root/deploy_runlist.js", "w") { |f| f.write runlist }
# Run chef-solo to deploy your code!
puts "Running chef-solo"
puts `#{solo} -c /root/chef-solo.conf -j /root/deploy_runlist.js -l debug`
exit(1) unless $?.success?
