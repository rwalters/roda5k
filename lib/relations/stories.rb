module Relations
  class Stories < ROM::Relation[:sql]
    TIMESTAMP = Types::Time.default { Time.now.utc }

    schema(:stories) do
      attribute :id,      Types::Serial
      attribute :author,  Types::String
      attribute :title,   Types::String
      attribute :body,    Types::String
      attribute :created_at,  TIMESTAMP
      attribute :updated_at,  TIMESTAMP
    end

    def by_id(id)
      where(id: id)
    end

    def all
      order(:author, :title, :id)
    end
  end
end
