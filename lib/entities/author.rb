class Author < Dry::Struct
  attribute :id,          Types::Strict::Int
  attribute :first_name,  Types::Strict::String
  attribute :last_name,   Types::Strict::String
  attribute :bio,         Types::Strict::String.constrained(min_size: 5, max_size: 255)
  attribute :created_at,  Types::Strict::Time
  attribute :updated_at,  Types::Strict::Time
end
