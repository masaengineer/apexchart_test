require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }

  # Sidekiq-schedulerの設定
  config.on(:startup) do
    schedule_file = Rails.root.join('config', 'sidekiq.yml')
    if File.exist?(schedule_file)
      # スケジューラを有効化
      Sidekiq::Scheduler.enabled = true
      # スケジュールの再読み込み
      Sidekiq::Scheduler.reload_schedule!
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end
