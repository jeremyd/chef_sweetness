maintainer       ""
maintainer_email "ops@example.com"
license          "Apache 2.0"
description      "Installs/Configures nomachinenx"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

recipe "nomachinenx::default", "installs nomachineNX"


attribute "nomachinenx/pass",
  :display_name => "nomachine Password",
  :description => "OPTIONAL: Password for your nomachine user account.",
  :required => false,
  :recipes => [ "nomachinenx::default" ]

attribute "nomachinenx/user",
  :display_name => "nomachine User",
  :description => "OPTIONAL: Username for your nomachine user account. Set this to $ignore if you would like to create a user manually.",
  :required => false,
  :recipes => [ "nomachinenx::default" ]

attribute "nomachinenx/ssh_port",
  :display_name => "openssh server port",
  :description => "listen port for openssh server",
  :required => false,
  :recipes => [ "nomachinenx::default" ],
  :default => "22"
