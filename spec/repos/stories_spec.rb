require 'spec_helper'

describe Repos::Stories do
  let(:repo) { Roda5k.repos[:stories] }

  before(:all) { Roda5k.repos[:authors].create(first_name: 'first', last_name: 'last', bio: 'short bio') }
  after(:all)  { Roda5k.repos[:authors].delete_all }

  before(:each) do
    titles.each do |title|
      repo.create(params.merge(title: title))
    end
  end

  after(:each) do
    repo.delete_all
  end

  let(:author) { Roda5k.repos[:authors].all.first }
  let(:params) do
    { author_id: author.id, body: 'foobar' }
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
