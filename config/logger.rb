require 'log_formatter'
require 'log_formatter/ruby_json_formatter'

Roda5k.config.logger = Logger.new(STDOUT)
Roda5k.logger.level = Logger::DEBUG

Roda5k.logger.formatter = Ruby::JSONFormatter::Base.new("%s[%d]"%['Roda5k', $$]) do |config|
  config[:type]   = :location
  config[:level]  = :level
  config[:app]    = :app
  config[:timestamp]  = :timestamp
end
