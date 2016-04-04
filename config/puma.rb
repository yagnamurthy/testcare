directory '/home/deployer/carespotter/current'

rackup '/home/deployer/carespotter/current/config.ru'

rails_env = ENV['RAILS_ENV'] || 'production'
environment rails_env


daemonize

pidfile '/home/deployer/carespotter/shared/tmp/pids/puma.pid'

state_path '/home/deployer/carespotter/shared/tmp/sockets/puma.state'

threads 0, 1

workers 0

bind 'unix:///home/deployer/carespotter/shared/tmp/sockets/puma.sock'

activate_control_app 'unix:///home/deployer/carespotter/shared/tmp/sockets/pumactl.sock', { auth_token: '5f68d7dc62333e4b39a81159478f3db3' }
