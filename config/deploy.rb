# config valid only for Capistrano 3.1
lock '3.4.1'

require 'airbrake/capistrano3'
require 'new_relic/recipes'

set :application, 'honeypot'
set :repo_url, 'https://github.com/ndlib/honeypot.git'
set :log_level, :info

# Default branch is :master
if fetch(:stage).to_s == 'production'
  set :branch, 'v1.0'
else
  if ENV["SCM_BRANCH"] && !(ENV["SCM_BRANCH"] == "")
    set :branch, ENV["SCM_BRANCH"]
  else
    ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
  end
end

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/app/honeypot'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}
set :linked_files, %w{config/secrets.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system public/images}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, { ld_library_path: "/opt/rh/rh-ruby24/root/usr/local/lib64:/opt/rh/rh-ruby24/root/usr/lib64:/opt/rh/rh-ruby24/root/usr/local/lib64:/opt/rh/rh-ruby24/root/usr/lib64:/usr/local/lib64:/usr/local/lib" }

# Default value for keep_releases is 5
# set :keep_releases, 5
before "deploy:symlink:linked_dirs", "test:path"

namespace :test do
  desc 'test'
  task :path do
    on roles(:web), in: :groups, limit: 3, wait: 10 do

      output = capture("vips --version")
      output.each_line do |line|
        puts line
      end
    end
  end
end

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

after 'deploy:finished', 'airbrake:deploy'
after "deploy:updated",     "newrelic:notice_deployment"
