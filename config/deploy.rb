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
set :git_enable_submodules, 1

# ADDED BY Net Theory
set :stages, ["staging", "preview"]
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

#

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end


namespace :lal do
  task :sphinx_tasks do
    run "cd '#{current_path}' && #{rake} ts:configure RAILS_ENV=#{rails_env} && #{sudo} chown www-data:dev #{current_path}/config/#{rails_env}.sphinx.conf" 
    run "#{sudo} chown -R www-data:dev #{current_path}/tmp/binlog"
  end  
  task :set_uploads_link do
    run "#{sudo} ln -s #{deploy_to}/shared/uploads #{release_path}/public/uploads"
    run "#{sudo} chown -R #{apache_user}:#{apache_group} #{release_path}/public/uploads"
  end
  task :set_ebooks_link do
    run "#{sudo} ln -s #{deploy_to}/shared/ebooks #{release_path}/ebooks"
    run "#{sudo} chown -R #{apache_user}:#{apache_group} #{release_path}/ebooks"
  end
  task :set_legacy_booktalk_images_link do
    run "#{sudo} ln -s #{deploy_to}/shared/book_talk_images #{release_path}/public/images/books2"
    run "#{sudo} chown -R #{apache_user}:#{apache_group} #{release_path}/public/images/books2"
  end
  task :set_legacy_pdfs_link do
    run "#{sudo} ln -s #{deploy_to}/shared/pdfs #{release_path}/public/images/pdfs"
    run "#{sudo} chown -R #{apache_user}:#{apache_group} #{release_path}/public/images/pdfs"
  end
  task :set_catalogs_link do
    run "#{sudo} ln -s #{deploy_to}/shared/catalogs #{release_path}/public/catalogs"
    run "#{sudo} chown -R #{apache_user}:#{apache_group} #{release_path}/public/catalogs"
  end
  
  
end



