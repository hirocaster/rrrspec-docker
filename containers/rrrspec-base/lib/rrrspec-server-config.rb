REDIS_CONFIG = { host: 'redis', port: 6379 }
DB_CONFIG = {
             adapter: 'mysql2',
             encoding: 'utf8mb4',
             charset: 'utf8mb4',
             collation: 'utf8mb4_general_ci',
             reconnect: false,
             database: 'rrrspec',
             pool: 5,
             host: 'mysql'
            }

RRRSpec.configure do |conf|
  conf.redis = REDIS_CONFIG
end

RRRSpec.configure(:server) do |conf|
  ActiveRecord::Base.default_timezone = :local
  conf.redis = REDIS_CONFIG

  conf.persistence_db = DB_CONFIG
  conf.execute_log_text_path = '/var/log/rrrspec'
end

RRRSpec.configure(:worker) do |conf|
  conf.redis = REDIS_CONFIG

  conf.rsync_remote_path = 'rsync://rsyncd/data/'
  conf.rsync_options = %w(
    --compress
    --times
    --recursive
    --links
    --perms
    --inplace
    --delete
  ).join(' ')

  conf.working_dir = '/mnt/working'
  conf.worker_type = 'default'
end

RRRSpec.configure(:web) do |conf|
  conf.persistence_db = DB_CONFIG
  conf.execute_log_text_path = '/var/log/rrrspec'
end

RRRSpec.configure(:client) do |conf|
  Time.zone_default = Time.find_zone('Asia/Tokyo')
  conf.redis = { host: 'redis', port: 6379 }

  conf.packaging_dir = `git rev-parse --show-toplevel`.strip
  conf.rsync_remote_path = 'rsync://rsyncd/data/'
  conf.rsync_options = %w(
    --compress
    --times
    --recursive
    --links
    --perms
    --inplace
    --delete
  ).join(' ')

  conf.spec_files = lambda do
    Dir.chdir(conf.packaging_dir) do
      Dir['spec/**{,/*/**}/*_spec.rb'].uniq
    end
  end

  conf.setup_command = <<-SETUP
    bundle config --global silence_root_warning 1
    ./bin/rrrspec-setup
  SETUP
  conf.slave_command = <<-SLAVE
    ./bin/rrrspec-slave-setup && bundle exec rrrspec-client slave
  SLAVE

  conf.taskset_class = 'myapplication'
  conf.worker_type = 'default'
  conf.max_workers = 10
  conf.max_trials = 3
  conf.unknown_spec_timeout_sec = 8 * 60
  conf.least_timeout_sec = 60
end
