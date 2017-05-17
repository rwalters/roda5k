class Story < Dry::Struct
  attribute :id,          Types::Strict::Int
  attribute :author,      Types::Strict::String
  attribute :title,       Types::Strict::String
  attribute :body,        Types::Strict::String.constrained(min_size: 5, max_size: 5120)
  attribute :created_at,  Types::Strict::Time
  attribute :updated_at,  Types::Strict::Time
end
