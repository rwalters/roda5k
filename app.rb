require './config/app'

class App < Roda
  # GET / request
  route do |r|
    r.root do
      debug("/")
      r.redirect "/story/create"
    end

    r.on "stories" do
      debug("stories")
      r.redirect "/story/all"
    end

    r.on "story" do
      debug("stories")
      r.get "all" do
        debug("all")
        StoryIndexView.new.call
      end

      r.get "create" do
        debug("create")
        curr_time = Time.now.to_i

        author = Roda5k.repos[:authors].all.sample if curr_time.even?
        author ||= Roda5k.repos[:authors].create(
          first_name: "First #{curr_time}",
          last_name: "Last #{curr_time}",
          bio: "Just a short Biography"
        )

        story = Roda5k.repos[:stories].create(
          author_id:  author.id,
          title:      "Title #{curr_time}",
          body:       "Body #{curr_time}"
        )

        r.redirect "#{story.id}"
      end

      r.get :id do |id|
        debug("ID: #{id}")
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

  private

  def debug(msg)
    Roda5k.logger.debug("[App Router]"){ msg }
  end
end
