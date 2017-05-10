require './config/app'

class App < Roda
  # GET / request
  route do |r|
    r.root do
      r.redirect "/story/create"
    end

    r.on "story" do
      r.get "create" do
        story = Roda5k.repos[:stories].create(
           author:  "Author #{Time.now.to_i}",
           title:   "Title #{Time.now.to_i}",
           body:    "Body #{Time.now.to_i}"
        )

        r.redirect "#{story.id}"
      end

      r.get :id do |id|
        begin
          StoryView.new.call({id: id})
        rescue ROM::TupleCountMismatchError => e
          Roda5k.logger.error("%s:%d"%[__FILE__, __LINE__]){ "Error routing to ID '%s'"%[id]}
          Roda5k.logger.error("%s:%d"%[__FILE__, __LINE__]){ e }

          r.redirect '/'
        end
      end
    end
  end
end
