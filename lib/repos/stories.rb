module Repos
  class Stories < ROM::Repository[:stories]
    # Define a command to create new stories.
    commands :create, update: :by_id, delete: :by_id

    def delete_all
      stories.delete_all
    end

    def all
      stories
        .all
        .as(Story)
        .to_a
    end

    def [](id)
      stories
        .by_id(id)
        .as(Story)
        .one!
    end
  end
end
