require 'spec_helper'

describe Repos::Authors do
  let(:repo) { Roda5k.repos[:authors] }

  after(:each) do
    repo.delete_all
  end

  before(:each) do
    last_names.each do |last_names|
      repo.create(params.merge(last_name: last_names))
    end
  end

  let(:params) do
    { first_name: 't title', bio: 'foobar' }
  end

  let(:last_names) { ['test author'] }

  describe "#create" do
    subject do
      repo.create(params.merge(last_name: 'lastName'))
    end

    it "creates a record" do
      expect{subject}.to change{repo.authors.all.count}.by(1)
    end
  end

  describe "#all" do
    subject { repo.all }

    it "retrieves all the records" do
      expect(subject.map(&:last_name)).to match_array(last_names)
    end
  end

  describe "#[]" do
    subject { repo[second_to_last_id] }

    let(:last_names)           { %w(new test foo bar ultimate penultimate) }
    let(:second_to_last)    { repo.all.last(2).first }
    let(:second_to_last_id) { second_to_last.id }

    it "retrieves the correct record" do
      expect(subject).to eq(second_to_last)
    end
  end
end
