class StoryUrl < Dry::View::Part
  def relative_url
    "/story/#{id}"
  end
end
