require "controllers/base_view"

class AuthorView < BaseView
  configure do |config|
    config.paths = self.template_paths(__dir__) | config.paths
    config.template = "author"
  end

  expose :author, as: AuthorName do |input|
    repo[input[:id]]
  end

  def initialize(repo: Roda5k.repos[:authors])
    super()

    @repo = repo
  end
end
