module Relations
  class Authors < ROM::Relation[:sql]
    TIMESTAMP = Types::Time.default { Time.now.utc }

    schema(:authors) do
      attribute :id,          Types::Serial
      attribute :first_name,  Types::String
      attribute :last_name,   Types::String
      attribute :bio,         Types::String
      attribute :created_at,  TIMESTAMP
      attribute :updated_at,  TIMESTAMP

      associations do
        has_many :books
      end
    end

    def delete_all
      debug("Delete All Authors")

      delete
    end

    def by_id(id)
      debug("Get Authors for id: #{id}")

      where(id: id)
    end

    def all
      debug("Get All Authors")

      order(authors[:last_name].qualified, authors[:first_name].qualified, authors[:id].qualified)
    end

    private

    def debug(msg)
      Roda5k.logger.debug("[#{self.class.name}]"){ msg }
    end
  end
end
