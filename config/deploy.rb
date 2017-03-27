require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/puma'

set :application_name, 'deploy-app'
set :domain, '127.0.0.1'
set :port, '2222'
set :user, 'deployer'
set :deploy_to, '/home/deployer/deploy-app'
set :repository, 'git@github.com:dmitriy-strukov/deploy-app.git'
set :branch, 'master'

set :rails_env, 'production'

task :environment do
  invoke :'rbenv:load'
end

task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    invoke :'puma:restart'
  end
end
