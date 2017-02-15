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

class App < Roda
  # GET / request
  route do |r| r.root do
      r.redirect "/hello"
    end

    r.on "hello" do
      @greeting = 'Hello'

      r.get "world" do
        "#{@greeting} world!"
      end

      r.is do
        r.get do
          "#{@greeting}!"
        end
      end

      r.post do
        puts "Someone said #{@greeting}!"
        r.redirect
      end
    end
  end
end
