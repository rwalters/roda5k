require 'roda'
require 'rom-sql'
require 'rom-repository'

require './config/dry'

Pathname.new("lib").children.each do |lib_dir|
  Pathname.new(lib_dir).children.each do |lib_file|
    filepath = [".",lib_file.to_s].join('/')
    require filepath
  end
end

require './config/rom'
