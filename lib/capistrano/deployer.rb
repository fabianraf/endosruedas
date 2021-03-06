# include files
load File.join(File.dirname(__FILE__), "lib", "utils.rb")
load File.join(File.dirname(__FILE__), "tasks", "setup.rb")
load File.join(File.dirname(__FILE__), "tasks", "deploy.rb")

#
#  TODO: Check for deployer version
#
DEPLOYER_VERSION = 0

#
#  Show deploy times
#
before :deploy, "deploy:start_timer"
after :deploy, "deploy:end_timer"

#
##
##  Each new environment setup
##
after "deploy:setup", "setup:create_apache_logs_dir"
#after "deploy:setup", "setup:checkout_files_dir"
after "deploy:setup", "setup:set_permissions"
#
##
##  After first checkout

#after "deploy:cold", "setup:create_database"
#after "deploy:cold", "setup:set_sites_enabled_link"


#  Each deployment

#before "deploy:create_symlink", "deploy:set_vendor_links"
# before "deploy:create_symlink", "deploy:update_files_dir"
before "deploy:create_symlink", "deploy:set_permissions"

after "deploy:create_symlink", "deploy:set_apache_link"

before "deploy:symlink", "assets:precompile"

namespace :assets do
  desc "Compile assets"
  task :precompile, :roles => :app do
    run "cd #{release_path} && bundle exec rake RAILS_ENV=#{rails_env} assets:precompile"
  end
end
