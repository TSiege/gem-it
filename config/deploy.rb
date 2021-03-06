require "rvm/capistrano"
require 'bundler/capistrano' # for bundler support
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :application, "gemit"
set :repository,  "git@github.com:TSiege/gemify.git"

set :user, 'tristan'
set :deploy_to, "/home/#{ user }/#{ application }"
set :use_sudo, false

set :scm, :git

role :web, "162.243.30.149"                          # Your HTTP server, Apache/etc
role :app, "162.243.30.149"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
 task :symlink_keys do
     run "#{try_sudo} ln -s #{shared_path}/application.yml #{release_path}/config/application.yml"
 end
end

after "deploy:create_symlink", "deploy:symlink_keys"
