require 'bundler/capistrano'

set :application, "uptime"
set :repository,  "git@github.com:jwigal/uptime.git"

set :user, "deploy"  # The server's user for deploys
#set :scm_passphrase, "p@ssw0rd"  # The deploy user's password
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/home/deploy/status.assignr.com/"

#set :repository,  "https://seed2.projectlocker.com/DropkickStudios/assignr/svn/assignr/trunk"
set :keep_releases, 4 


set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

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
end