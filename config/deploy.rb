require 'bundler/capistrano'

set :application, "uptime"
set :repository,  "git@github.com:jwigal/uptime.git"
set :user, "deploy"  # The server's user for deploys
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/home/deploy/status.assignr.com/"
set :keep_releases, 4 
set :scm, :git

role :web, "status.assignr.com"                          # Your HTTP server, Apache/etc
role :app, "status.assignr.com"                          # This may be the same as your `Web` server
role :db,  "status.assignr.com", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  tast :move_database_yml do
    run "cp /home/deploy/status.assignr.com/shared/database.yml #{File.join(current_path,'config','database.yml')}"
  end
end
after "deploy:update", "deploy:cleanup" 
