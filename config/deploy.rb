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

  # desc "Installs required gems"
  # task :gems, :roles => :app do
  #   run "cd #{current_path} && sudo rake gems:install RAILS_ENV=production"
  # end
  # 
  # after "deploy:setup", "deploy:gems"
  # 
  # before "deploy", "deploy:web:disable"
  # 
  # after "deploy", "deploy:web:enable"
end

namespace :rake do
  desc "Run a task on a remote server."
  # run like: cap staging rake:invoke task=a_certain_task
  task :invoke do
    run("cd #{deploy_to}/current; /usr/bin/env rake #{ENV['task']} RAILS_ENV=#{rails_env}")
  end
end

namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end

  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --without test"
  end

  task :lock, :roles => :app do
    run "cd #{current_release} && bundle lock;"
  end

  task :unlock, :roles => :app do
    run "cd #{current_release} && bundle unlock;"
  end
end


after "deploy:update_code" do
  bundler.bundle_new_release
end

after "deploy", "deploy:cleanup"