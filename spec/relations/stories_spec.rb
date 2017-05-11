require 'spec_helper'

describe Relations::Stories do
  let(:repo) { Roda5k.repos[:stories] }

  let(:stories) { repo.stories }

  before(:each) do
    authors.each do |name|
      repo.create(params.merge(author: name))
    end
  end

  after(:each) do
    repo.delete_all
  end

  let(:authors) { %w(new test foo bar ultimate penultimate) }
  let(:params) do
    { title: 't title', body: 'body blah' }
  end


  describe "#by_id" do
    subject do
      stories.by_id(book_record.id).to_a
    end
    let(:book_record) { repo.all.first }

    it "finds the right author" do
      expect(subject.first.author).to eq(authors.sort.first)
    end
  end

  describe "#all" do
    subject do
      stories.all.to_a
    end

    let(:authors) { ['test author', 'different author'] }

    it "exists" do
      expect(subject.count).to eq(2)
    end

    it "is the correct order" do
      expect(subject.map(&:author)).to match_array(authors.sort)
    end
  end
end
