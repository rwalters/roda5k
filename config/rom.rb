require 'relations/stories'
require 'relations/authors'
require 'repos/stories'
require 'repos/authors'

config = ROM::Configuration.new(:sql, Roda5k.config.db.dsn)
config.register_relation(Relations::Stories)
config.register_relation(Relations::Authors)

container = ROM.container(config)
container.gateways[:default].tap do |gateway|
  migration = gateway.migration do
    change do
      create_table :stories do
        primary_key :id
        foreign_key :author_id,  :authors
        column :title,      String, null: false
        column :body,       String, null: false
        column :created_at, Time,   null: false
        column :updated_at, Time,   null: false
      end
    end
  end
  migration.apply(gateway.connection, :up)

  migration = gateway.migration do
    change do
      create_table :authors do
        primary_key :id
        column :first_name, String, null: false
        column :last_name,  String, null: false
        column :bio,        String, null: false
        column :created_at, Time,   null: false
        column :updated_at, Time,   null: false
      end
    end
  end

  migration.apply(gateway.connection, :up)
end

Roda5k.config.container = container

Roda5k.config.repos[:stories] = Repos::Stories.new(container)
Roda5k.config.repos[:authors] = Repos::Authors.new(container)
