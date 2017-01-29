require "rom-sql"
require "rom-repository"

config = ROM::Configuration.new(:sql, "sqlite::memory")
config.register_relation Relations::Articles
container = ROM.container(config)

container.gateways[:default].tap do |gateway|
  migration = gateway.migration do
    change do
      create_table :stories do
        primary_key :id
        string :author, null: false
        string :title,  null: false
        string :body,   null: false
      end
    end
  end
  migration.apply gateway.connection, :up
end

STORY_REPO = Repositories::Stories.new(container)
