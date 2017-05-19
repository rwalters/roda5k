require 'entities/story'

module Repos
  class Stories < ROM::Repository[:stories]
    commands :create, update: :by_id, delete: :by_id
    relations :authors

    def delete_all
      stories.delete_all
    end

    def by_id_with_author(id)
      debug("#{__callee__} for id: #{id}")

      stories
        .wrap_parent(author: authors)
        .by_id(id)
        .one!
    end

    def all_with_author
      debug("Get all Stories with Author")

      stories
        .wrap_parent(author: authors)
        .all
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
