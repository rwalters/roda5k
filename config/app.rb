$:.unshift Pathname.pwd.join('lib').expand_path

require 'roda'
require 'rom-sql'
require 'rom-repository'

require 'dry-configurable'
require './config/dry'

class Roda5k
  extend Dry::Configurable

  setting :db do
    setting :dsn, "sqlite::memory"
  end
  setting :root, Pathname.pwd.expand_path

  setting :logger, reader: true
  setting :container, reader: true
  setting :repos, Hash.new(''), reader: true
end

require './config/logger'
require './config/rom'
