require 'spec_helper'

describe Repos::Stories do
  let(:repo) { Roda5k.repos[:stories] }

  after(:each) do
    repo.delete_all
  end

  before(:each) do
    titles.each do |title|
      repo.create(params.merge(title: title))
    end
  end

  let(:params) do
    { author_id: 1, body: 'foobar' }
  end

  let(:titles) { ['test title'] }

  describe "#create" do
    subject do
      repo.create(params.merge(title: 'creation test title'))
    end

    it "creates a record" do
      expect{subject}.to change{repo.stories.all.count}.by(1)
    end
  end

  describe "#all" do
    subject { repo.all }

    it "retrieves all the records" do
      expect(subject.map(&:title)).to match_array(titles)
    end
  end

  describe "#[]" do
    subject { repo[second_to_last_id] }

    let(:titles)           { %w(new test foo bar ultimate penultimate) }
    let(:second_to_last)    { repo.all.last(2).first }
    let(:second_to_last_id) { second_to_last.id }

    it "retrieves the correct record" do
      expect(subject).to eq(second_to_last)
    end
  end
end
