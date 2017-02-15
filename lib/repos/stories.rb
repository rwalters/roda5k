module Repos
  class Stories < ROM::Repository[:stories]
    # Define a command to create new stories.
    commands :create, update: :by_id

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
