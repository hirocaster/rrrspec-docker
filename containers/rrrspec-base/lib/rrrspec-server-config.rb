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
  conf.execute_log_text_path = '/vol/rrrspec-log-texts'
end

RRRSpec.configure(:worker) do |conf|
  conf.redis = REDIS_CONFIG

  conf.rsync_remote_path = 'rsync://rsyncd/share/'
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
  conf.execute_log_text_path = '/tmp/rrrspec-log-texts'
end
