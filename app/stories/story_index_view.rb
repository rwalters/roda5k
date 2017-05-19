require "controllers/base_view"
require_relative "parts/story_url"

class StoryIndexView < BaseView
  configure do |config|
    config.paths = self.template_paths(__dir__) | config.paths
    config.template = "stories"
  end

  expose :stories, as: StoryUrl do
    repo.all_with_author
  end

  def initialize(repo: Roda5k.repos[:stories])
    super()

    @repo = repo
  end
end
