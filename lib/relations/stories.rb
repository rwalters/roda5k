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

    def delete_all
      debug("Delete All Stories")

      delete
    end

    def by_id(id)
      debug("Get Stories for id: #{id}")

      where(id: id)
    end

    def all
      debug("Get All Stories")

      order(:author, :title, :id)
    end

    private

    def debug(msg)
      Roda5k.logger.warn("[%s] %s"%[self.class.name, msg])
    end
  end
end
