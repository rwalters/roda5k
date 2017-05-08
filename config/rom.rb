require 'relations/stories'
require 'repos/stories'

config = ROM::Configuration.new(:sql, Roda5k.config.db.dsn)
config.register_relation(Relations::Stories)

container = ROM.container(config)
container.gateways[:default].tap do |gateway|
  migration = gateway.migration do
    change do
      create_table :stories do
        primary_key :id
        column :author, String, null: false
        column :title,  String, null: false
        column :body,   String, null: false
        column :created_at, Time, null: false
        column :updated_at, Time, null: false
      end
    end
  end

  migration.apply(gateway.connection, :up)
end

Roda5k.config.container = container

Roda5k.config.repos[:stories] = Repos::Stories.new(container)
