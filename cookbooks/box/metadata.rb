maintainer       "Rubyonlinux"
maintainer_email "na"
license          "Apache 2.0"
description      "Installs/Configures myl33tbox"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

recipe "box::packages", "installs all necessary packages for l33tness"
recipe "box::templates", "the rest"
all_recipes = ["box::packages", "box::templates"]

attribute "box/user", :display_name => "Username you want to use to login to your l33tbox", :type => "string", :required => true, :recipes => all_recipes
attribute "box/authorized_keys", :display_name => "Authorized keys file in ~/.ssh/authorized_keys for user", :type => "string", :required => true, :recipes => all_recipes
attribute "box/skype_username", :display_name => "Your Skype username is required for use of l33tbox with Skype.", :type => "string", :required => false, :recipes => all_recipes
attribute "box/skype_password", :display_name => "Your Skype password is required for use of l33tbox with Skype.  It will only be stored on the box as a SHA1 hash.", :type => "string", :required => false, :recipes => all_recipes
