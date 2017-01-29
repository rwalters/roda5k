module Entities
  class Story < ROM::Relation[:sql]
    schema(:articles) do
      attribute :id,      Types::Serial
      attribute :author,  Types::String
      attribute :title,   Types::String
      attribute :body,    Types::String
    end

    def by_id(id)
      where(id: id)
    end
  end
end
