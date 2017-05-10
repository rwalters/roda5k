require 'entities/story'

module Repos
  class Stories < ROM::Repository[:stories]
    # Define a command to create new stories.
    commands :create, update: :by_id, delete: :by_id

    def delete_all
      stories.delete_all
    end

    def all
      debug("Get all Stories")

      stories
        .all
        .as(Story)
        .to_a
    end

    def [](id)
      debug("Get Stories for id: #{id}")

      stories
        .by_id(id)
        .as(Story)
        .one!
    end

    private

    def debug(msg)
      Roda5k.logger.debug("[#{self.class.name}]"){ msg }
    end
  end
end
