
#
#  Override default deploy namespace
#
namespace :deploy do

	#
	#  Kickoff Passenger
	#
	task :start, :roles => :app do
		run "touch #{current_path}/tmp/restart.txt"  
	end

 	#
 	#  Restart Passenger
 	#
	task :restart, :roles => :app do  
		run "touch #{current_path}/tmp/restart.txt"
	end 

 	#
	#  Run migrations on the database 
	#
	task :migrate, :roles => :db do
		run "cd #{current_path};  #{ruby_path}/rake RAILS_ENV=#{rails_env} db:migrate"
	end 

 	#
	#  Restart Apache using the /etc/init.d script
	#
	desc "Restart Apache:  used to get new configuration enabled"
	task :restart_apache, :roles => :app do
		run "#{sudo} #{apache_init} restart"
	end

 	#
	#  Update the apache configuration with the new version:
	#
	#  Symbolic link:
	#  SITE_ROOT/config/apache/environment.conf  -->  APACHE_DIR/sites-available/
	#
	#  Note:  must perform after the symlink because it alters the rollback state
	#
	desc "Create a link to the apache sites-available directory"
	task :set_apache_link do
		run "
			#{sudo} rm -f #{apache_config}/#{apache_config_file} && \
			#{sudo} ln -s #{current_path}/config/apache/apache-#{rails_env}.conf #{apache_config}/#{apache_config_file}
		"
	end

  # Creates a symlink for uploads 
  desc "Create a link to the uploads directory"
	task :set_uploads_link do
		run "
			#{sudo} ln -s #{deploy_to}/shared/system/uploads #{release_path}/uploads && \
      #{sudo} chown -R #{apache_user}:dev #{release_path}/uploads
		"
	end
  
  # Creates a symlink for invoices
  desc "Create a link to the invoices directory"
	task :set_invoices_link do
		run "
			#{sudo} ln -s #{deploy_to}/shared/invoices #{release_path}/invoices && \
      #{sudo} chown -R #{apache_user}:dev #{release_path}/invoices
		"
	end
  
	#
	#  Setup the permissions of the newly checked out files:
	#
	#  Note:  Perform during "before:symlink" callback.  
	#  			we want it to be ready when we switch current
	#
	desc "Set permissions on the newly checked out files"
	task :set_permissions do
    set_file_permissions(release_path)
	end

	#
	#  Create links to the files repository of libraries 
	#
	#  Note:  perform during "before:symlink" callback
	#  			we want it to be ready when we switch
	#
	desc "Link to repository libraries in files directory"
	task :set_vendor_links do
		run "
			#{sudo} rm -f #{release_path}/vendor/plugins && \
			#{sudo} rm -f #{release_path}/vendor/rails && \
			#{sudo} ln -s #{deploy_to}/files/plugins #{release_path}/vendor/plugins && \
			#{sudo} ln -s #{deploy_to}/files/rails-2.3.8 #{release_path}/vendor/rails 
		"
	end

	#
	#  Update the files dir
	#
	desc "Update the files directory"
	task :update_files_dir do 
		run "#{sudo} svn up #{deploy_to}/files"
    set_file_permissions(files_dir)
	end

  #
  #  Print the time at the start
  #
  task :start_timer do 
    puts "\n\n
    Started deployment at: #{start_time}
    \n\n"
  end

  #
  #  Print the time at the end
  #
  task :end_timer do
    puts "\n\n
    Ended deployment at: #{end_time} \n
    Total Time: #{total_time} seconds
    \n\n"
  end


end
