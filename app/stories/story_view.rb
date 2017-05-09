require "controllers/base_view"

class StoryView < BaseView
  configure do |config|
    config.paths = self.template_paths(__dir__) | config.paths
    config.template = "story"
  end

  expose :story do |input|
    repo[input[:id]]
  end

  def initialize(repo: Roda5k.repos[:stories])
    super()

    @repo = repo
  end
end
