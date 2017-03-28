directory '/home/deployer/deploy-app/current'

rackup '/home/deployer/deploy-app/current/config.ru'

environment 'production'

daemonize true

pidfile '/home/deployer/deploy-app/shared/tmp/pids/puma.pid'

state_path '/home/deployer/deploy-app/shared/tmp/sockets/puma.state'

bind 'unix:///home/deployer/deploy-app/shared/tmp/sockets/puma.sock'

activate_control_app 'unix:///home/deployer/deploy-app/shared/tmp/sockets/pumactl.sock', { auth_token: '5f68d7dc62333e4b39a81159478f3db3' }
