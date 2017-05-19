require 'spec_helper'

describe Relations::Stories do
  let(:repo) { Roda5k.repos[:stories] }
  let(:stories) { repo.stories }

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
  let(:titles) { %w(new test foo bar ultimate penultimate) }
  let(:params) do
    { author_id: author.id, body: 'body blah' }
  end


  describe "#by_id" do
    subject do
      stories.by_id(book_record.id).to_a
    end
    let(:book_record) { repo.all.first }

    it "finds the right title" do
      expect(subject.first.title).to eq(titles.sort.first)
    end
  end

  describe "#all" do
    subject do
      stories.all.to_a
    end

    let(:titles) { ['test title', 'different title'] }

    it "exists" do
      expect(subject.count).to eq(2)
    end

    it "is the correct order" do
      expect(subject.map(&:title)).to match_array(titles.sort)
    end
  end
end
