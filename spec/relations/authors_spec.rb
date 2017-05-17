require 'spec_helper'

describe Relations::Authors do
  let(:repo) { Roda5k.repos[:authors] }

  let(:authors) { repo.authors }

  before(:each) do
    last_names.each do |last_name|
      repo.create(params.merge(last_name: last_name))
    end
  end

  after(:each) do
    repo.delete_all
  end

  let(:last_names) { %w(new test foo bar ultimate penultimate) }
  let(:params) do
    { first_name: 't title', bio: 'bio blah' }
  end


  describe "#by_id" do
    subject do
      authors.by_id(author_record.id).to_a
    end
    let(:author_record) { repo.all.first }

    it "finds the right author" do
      expect(subject.first.last_name).to eq(last_names.sort.first)
    end
  end

  describe "#all" do
    subject do
      authors.all.to_a
    end

    let(:last_names) { ['test author', 'different author'] }

    it "exists" do
      expect(subject.count).to eq(2)
    end

    it "is the correct order" do
      expect(subject.map(&:last_name)).to match_array(last_names.sort)
    end
  end
end
