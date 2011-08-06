set :application, "thebabytime"
set :repository,  "git@github.com:gicappa/thebabytime.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, 'www-data'

set :deploy_to, "/srv/www/thebabytime.com/htdocs"

set :use_sudo, false


role :web, "giankavh"                          # Your HTTP server, Apache/etc
role :app, "giankavh"                          # This may be the same as your `Web` server
role :db,  "giankavh", :primary => true # This is where Rails migrations will run
role :db,  "giankavh"

default_run_options[:pty] = true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Installs required gems"
  task :gems, :roles => :app do
    run "cd #{current_path} && sudo rake gems:install RAILS_ENV=production"
  end
  after "deploy:setup", "deploy:gems"

  before "deploy", "deploy:web:disable"
  after "deploy", "deploy:web:enable"
end
