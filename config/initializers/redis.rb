uri = URI.parse(redis://localhost:6379/12)
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
