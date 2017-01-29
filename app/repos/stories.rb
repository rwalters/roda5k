module Repos
  class Stories < ROM::Repository[:stories]
    # Define a command to create new stories.
    commands :create

    def [](id)
      stories.by_id(id).one!
    end
  end
end
