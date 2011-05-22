
if node.platform == 'ubuntu' && node.platform_version == '11.04'
  template "/etc/apt/sources.list" do
    source "sources.list.erb"
  end

  bash "apt-get update" do
    code "apt-get update"
  end
  
  package 'appmenu-qt'
  
  package 'binutils'
  
  package 'bitlbee'
  
  package 'bitlbee-common'
  
  package 'bitlbee-plugin-skype'
  
  package 'blackbox'
  
  package 'build-essential'
  
  package 'cryptsetup'
  
  package 'dpkg-dev'
  
  package 'ecryptfs-utils'
  
  package 'fakeroot'
  
  package 'g++'
  
  package 'g++-4.5'
  
  package 'gcc'
  
  package 'gcc-4.5'
  
  package 'keyutils'
  
  package 'libalgorithm-diff-perl'
  
  package 'libalgorithm-diff-xs-perl'
  
  package 'libalgorithm-merge-perl'
  
  package 'libaudio2'
  
  package 'libbt'
  
  package 'libc-dev-bin'
  
  package 'libc6-dev'
  
  package 'libdbusmenu-qt2'
  
  package 'libdpkg-perl'
  
  package 'libecryptfs0'
  
  package 'libevent-1.4-2'
  
  package 'libgl1-mesa-dri'
  
  package 'libgl1-mesa-glx'
  
  package 'libgomp1'
  
  package 'liblcms1'
  
  package 'libmng1'
  
  package 'libnspr4'
  
  package 'libnss3'
  
  package 'libnss3-1d'
  
  package 'libqt4-dbus'
  
  package 'libqt4-network'
  
  package 'libqt4-xml'
  
  package 'libqtcore4'
  
  package 'libqtgui4'
  
  package 'libreadline5'
  
  package 'libruby1.8'
  
  package 'libstdc++6-4.5-dev'
  
  package 'libutempter0'
  
  package 'libvncserver0'
  
  package 'libxaw7'
  
  package 'libxcb-shape0'
  
  package 'libxkbfile1'
  
  package 'libxmu6'
  
  package 'libxpm4'
  
  package 'libxss1'
  
  package 'libxt6'
  
  package 'libxtst6'
  
  package 'libxv1'
  
  package 'libxxf86dga1'
  
  package 'libxxf86vm1'
  
  package 'linux-libc-dev'
  
  package 'lynx'
  
  package 'lynx-cur'
  
  package 'make'
  
  package 'manpages-dev'
  
  package 'patchutils'
  
  package 'python-gnutls'
  
  package 'python-skype'
  
  package 'ruby'
  
  package 'ruby1.8'
  
  package 'ruby1.8-dev'
  
  package 'rubygems'
  
  package 'rubygems1.8'
  
  package 'skype'
  
  package 'skyped'
  
  package 'tcl'
  
  package 'tcl8.4'
  
  package 'tk'
  
  package 'tk8.4'
  
  package 'x11-utils'
  
  package 'x11-xkb-utils'
  
  package 'x11vnc'
  
  package 'x11vnc-data'
  
  package 'xbitmaps'
  
  package 'xfonts-base'
  
  package 'xserver-common'
  
  package 'xterm'
  
  package 'xvfb'

  package 'dircproxy'

  package 'expect'

  package 'monit'
  
end
