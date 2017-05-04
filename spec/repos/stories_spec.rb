require 'spec_helper'

describe Repos::Stories do
  after(:each) do
    STORY_REPO.delete_all
  end

  before(:each) do
    authors.each do |name|
      STORY_REPO.create(params.merge(author: name))
    end
  end

  let(:params) do
    { title: 't title', body: 'blah' }
  end

  let(:authors) { ['test author'] }

  describe "#create" do
    subject do
      STORY_REPO.create(params.merge(author: 'creation test author'))
    end

    it "creates a record" do
      expect{subject}.to change{STORY_REPO.stories.all.count}.by(1)
    end
  end

  describe "#all" do
    subject { STORY_REPO.all }

    it "retrieves all the records" do
      expect(subject.map(&:author)).to match_array(authors)
    end
  end

  describe "#[]" do
    subject { STORY_REPO[second_to_last_id] }

    let(:authors)           { %w(new test foo bar ultimate penultimate) }
    let(:second_to_last)    { STORY_REPO.all.last(2).first }
    let(:second_to_last_id) { second_to_last.id }

    it "retrieves the correct record" do
      expect(subject).to eq(second_to_last)
    end
  end
end
