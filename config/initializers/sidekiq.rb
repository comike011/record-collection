Sidekiq::Logging.logger.level = Logger::INFO

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://localhost:6379/12" }
  config.error_handlers << proc { |ex, ctx_hash| Notify.log(ex, ctx_hash) }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://localhost:6379/12" }
end
