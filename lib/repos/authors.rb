require 'entities/author'

module Repos
  class Authors < ROM::Repository[:authors]
    commands :create, update: :by_id, delete: :by_id
    relations :stories

    def delete_all
      authors.delete_all
    end

    def all
      debug("Get all Authors")

      authors
        .all
        .as(Author)
        .to_a
    end

    def [](id)
      debug("Get Authors for id: #{id}")

      authors
        .by_id(id)
        .as(Author)
        .one!
    end

    private

    def debug(msg)
      Roda5k.logger.debug("[#{self.class.name}]"){ msg }
    end
  end
end
