require "bundler/capistrano"
# require 'capistrano/ext/multistage'
load "lib/capistrano/deployer.rb"
set :application, "endosruedas"
set :scm, :git
set :repository,  "git@github.com:fabianraf/endosruedas.git"
set :scm_passphrase, ""
global_defaults
ssh_options[:forward_agent] = true
set :branch, "master"


# ADDED BY Net Theory
set :stages, ["staging", "preview", "production"]
# set :default_stage, "staging"

task :preview do
  set :rails_env, "preview"
  set :user, "deployer"
  server "ec2-54-209-89-208.compute-1.amazonaws.com", :app, :web, :db, :primary => true
  defaults
  set :default_environment, {'PATH'=> "/usr/local/ruby/bin:$PATH"}
  set :deploy_via, :remote_cache  
  set :apache_user, "www-data"
  set :apache_group, "dev"
  set :apache_dir, "/etc/apache2"
  set :apache_config, "/etc/apache2/sites-available"
end

task :production do
  set :rails_env, "production"
  set :user, "deployer"
  server "ec2-54-209-89-208.compute-1.amazonaws.com", :app, :web, :db, :primary => true
  defaults
  set :default_environment, {'PATH'=> "/usr/local/ruby/bin:$PATH"}
  set :deploy_via, :remote_cache  
  set :apache_user, "www-data"
  set :apache_group, "dev"
  set :apache_dir, "/etc/apache2"
  set :apache_config, "/etc/apache2/sites-available"
end

#

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end




