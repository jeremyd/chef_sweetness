books_refresh Mash.new unless attribute?("books_refresh")
books_refresh[:git_repo] = 'git://github.com/jeremyd/rs_git_skel.git' unless books_refresh.has_key?(:git_repo)
#TODO: im sure chef stores this home var somewhere..
books_refresh[:chef_home] = "/var/chef" unless books_refresh.has_key?(:chef_home)
books_refresh[:target_subdir] = "/cookbooks" unless books_refresh.has_key?(:target_subdir)
