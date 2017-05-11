require 'spec_helper'

describe Repos::Stories do
  let(:repo) { Roda5k.repos[:stories] }

  after(:each) do
    repo.delete_all
  end

  before(:each) do
    authors.each do |name|
      repo.create(params.merge(author: name))
    end
  end

  let(:params) do
    { title: 't title', body: 'foobar' }
  end

  let(:authors) { ['test author'] }

  describe "#create" do
    subject do
      repo.create(params.merge(author: 'creation test author'))
    end

    it "creates a record" do
      expect{subject}.to change{repo.stories.all.count}.by(1)
    end
  end

  describe "#all" do
    subject { repo.all }

    it "retrieves all the records" do
      expect(subject.map(&:author)).to match_array(authors)
    end
  end

  describe "#[]" do
    subject { repo[second_to_last_id] }

    let(:authors)           { %w(new test foo bar ultimate penultimate) }
    let(:second_to_last)    { repo.all.last(2).first }
    let(:second_to_last_id) { second_to_last.id }

    it "retrieves the correct record" do
      expect(subject).to eq(second_to_last)
    end
  end
end
