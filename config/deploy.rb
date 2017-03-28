require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/nginx'
require 'mina/puma'

set :application_name, 'deploy-app'
set :domain, '127.0.0.1'
set :port, '2222'
set :user, 'deployer'
set :shared_dirs,  fetch(:shared_dirs, []).push('tmp', 'log', 'public/uploads', 'public/system')
set :shared_files, fetch(:shared_files, []).push('config/puma.rb', 'config/database.yml', 'config/secrets.yml')
set :deploy_to, '/home/deployer/deploy-app'
set :repository, 'git@github.com:dmitriy-strukov/deploy-app.git'
set :branch, 'master'

set :rails_env, 'production'

task :environment do
  invoke :'rbenv:load'
end

task setup: :environment do
  command %{mkdir -p "#{fetch(:shared_path)}/log"}
  command %{chmod g+rx,u+rwx "#{fetch(:shared_path)}/log"}

  command %{mkdir -p "#{fetch(:shared_path)}/config"}
  command %{chmod g+rx,u+rwx "#{fetch(:shared_path)}/config"}

  command %{touch "#{fetch(:shared_path)}/config/puma.rb"}
  command %{touch "#{fetch(:shared_path)}/config/database.yml"}
  command %{touch "#{fetch(:shared_path)}/config/secrets.yml"}
  command %{echo "-----> Be sure to edit '#{fetch(:shared_path)}/config/database.yml', 'secrets.yml', 'puma.rb' and 'sidekiq.yml'."}

  command %{mkdir -p "#{fetch(:shared_path)}/tmp/sockets"}
  command %{chmod g+rx,u+rwx "#{fetch(:shared_path)}/tmp/sockets"}
  command %{mkdir -p "#{fetch(:shared_path)}/tmp/pids"}
  command %{chmod g+rx,u+rwx "#{fetch(:shared_path)}/tmp/pids"}
end

task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'

    on :build do
      invoke :'bundle:install'
      invoke :'rails:db_migrate'
      invoke :'rails:assets_precompile'
      invoke :'deploy:cleanup'
    end

    on :launch do
      invoke :'puma:restart'
    end
  end
end
