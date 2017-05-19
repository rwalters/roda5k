module Relations
  class Stories < ROM::Relation[:sql]
    TIMESTAMP = Types::Time.default { Time.now.utc }

    schema(:stories) do
      attribute :id,          Types::Serial
      attribute :author_id,   Types::ForeignKey(:authors)
      attribute :title,       Types::String
      attribute :body,        Types::String
      attribute :created_at,  TIMESTAMP
      attribute :updated_at,  TIMESTAMP

      associations do
        belongs_to :author
      end
    end

    def delete_all
      debug("Delete All Stories")

      delete
    end

    def by_id(id)
      debug("#{__callee__} for id: #{id}")

      by_pk(id)
    end

    def all
      debug("Get All Stories")

      order(stories[:title].qualified, stories[:id].qualified)
    end

    private

    def debug(msg)
      Roda5k.logger.debug("[#{self.class.name}]"){ msg }
    end
  end
end
