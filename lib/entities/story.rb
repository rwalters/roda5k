class Story < Dry::Struct
  attribute :id,      Types::Strict::Int
  attribute :author,  Types::Strict::String
  attribute :title,   Types::Strict::String
  attribute :body,    Types::Strict::String
  attribute :created_at,  Types::Strict::Time
  attribute :updated_at,  Types::Strict::Time
end
