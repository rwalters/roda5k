require 'roda'

class App < Roda
  # GET / request
  route do |r|
    r.root do
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
