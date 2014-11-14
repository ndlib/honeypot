# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'honeypot'
set :repo_url, 'https://github.com/ndlib/honeypot.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

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

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{log public/images}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, { path: "/opt/ruby/current/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

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

namespace :und do

  desc "Run puppet using the modules supplied by the application"
  task :puppet do
    local_module_path = File.join(release_path, 'puppet', 'modules')
    puppet_apply = %Q{sudo puppet apply --modulepath=#{local_module_path}:/global/puppet_standalone/modules:/etc/puppet/modules -e "class { 'lib_iipimage': }"}
    on roles(:web) do
      execute puppet_apply
    end 
  end
end

after "deploy:updated", "und:puppet"
