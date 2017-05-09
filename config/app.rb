require 'pathname'
require 'roda'
require 'rom-sql'
require 'rom-repository'
require './config/dry'

class Roda5k
  extend Dry::Configurable

  setting :db do
    setting :dsn, "sqlite::memory"
  end
  setting :root, Pathname.new(__dir__).parent

  setting :logger, reader: true
  setting :container, reader: true
  setting :repos, Hash.new(''), reader: true
end

%w(lib app app/stories).each do |dir|
  $:.unshift Roda5k.config.root.join(dir).expand_path.to_s
end

require './config/logger'
require './config/rom'
require './config/views'
