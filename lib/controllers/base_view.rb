class BaseView < Dry::View::Controller
  configure do |config|
    templ_dir = Roda5k.config.root.join("lib/templates")
    config.paths = [templ_dir.to_s] | templ_dir.children.map(&:to_s)

    config.layout = "app"
  end

  private
  attr_reader :repo

  def self.template_paths(dir)
    [
      Pathname
      .new(dir)
      .join('templates')
      .expand_path
      .to_s
    ]
  end
end
