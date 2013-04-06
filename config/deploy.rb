# -*- coding: iso-8859-1 -*-
require 'capistrano/ext/multistage'
require "bundler/capistrano"
require "rvm/capistrano"
#require 'capistrano-unicorn'
set :application, "FoodWebBuilder"

default_run_options[:pty] = true  # Must be set for the password prompt from #git to work    
set :repository, "https://github.com/jjliang/databaseui.git"  # Your clone URL
set :scm, "git"

set :deploy_via, :remote_cache  #If omitted each deploy will do a full repository clone 
set :git_shallow_clone, 1  # only copy the most recent, not the entire repository (default:1)  

# set :deploy_to, "/var/www" #specify where on the server our application resides 
set :user, "fwb" #The server's user for deploys
set :use_sudo, false
set :scm_password, Proc.new { Capistrano::CLI.password_prompt "SCM Password: "}

# Define stage and productipn environments
set :stages, %w(production staging)
set :default_stage, "staging"

# after "deploy:restart", "deploy:cleanup" #clean up old releases on each deploy uncomment this

# =============================================================================
# TASKS 
# =============================================================================

#  Multiple Stages Without Multistage Extension
#  https://github.com/capistrano/capistrano/wiki/2.x-Multiple-Stages-Without-Multistage-Extension
#
#  cap production deploy - to deploy to prod. / deploy to stage => cap deploy
#  cap production deploy:restart
task :production do
  role :web, "fwb.cs.umb.edu"   # Your HTTP server, Apache/etc (where your web server software runs)
  role :app, "fwb.cs.umb.edu"   # This may be the same as your `Web` server
  role :db,  "127.0.0.0.1", :primary => true 	# This is where Rails migrations will run 
  set :deploy_to, "/var/rails/fwb" #specify where on the server our application resides 
  set :deploy_via, :remote_cache # only copy the most recent, not the entire repository
  set :branch, "production" #branch to checkout during deployment
end

task :staging do
  
  role :web, "fwb.cs.umb.edu"   # Your HTTP server, Apache/etc (where your web server software runs)
  role :app, "fwb.cs.umb.edu"   # This may be the same as your `Web` server
  role :db,  "fwb.cs.umb.edu", :primary => true 	# This is where Rails migrations will run
  
  set :rails_env, "production"
  set :deploy_to, "/var/rails/fwb/current"
  set :deploy_via, :remote_cache # only copy the most recent, not the entire repository
  set :branch, "staging" #branch to checkout during deployment
end

# added two tasks hooks as required by capistrano-unicorn
after 'deploy:restart', 'unicorn:reload'
after 'deploy:restart', 'unicorn:restart'

# =============================================================================
# SSH OPTIONS
# =============================================================================
# ssh_options[:keys] = %w(/path/to/my/key /path/to/another/key)
# ssh_options[:port] = 25
#If you're using your own private keys for git, you want to tell Capistrano 
#to use agent forwarding with this command. Agent forwarding can make key management
#much simpler as it uses your local keys instead of keys installed on the server
 set :ssh_options, { :forward_agent => true, :paranoid => false }
 
