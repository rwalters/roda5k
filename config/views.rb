Dir.glob('app/stories/*_view*').each do |story|
  require "stories/#{File.basename(story, '.rb')}"
end
