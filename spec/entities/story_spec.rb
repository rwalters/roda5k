require 'spec_helper'

describe Story do
  let(:repo) { Roda5k.repos[:stories] }

  subject do
    described_class.new(params)
  end

  let(:params) do
    { id: id, author_id: author_id, title: title, body: body, created_at: c_at, updated_at: u_at }
  end

  let(:id)        { 1 }
  let(:author_id) { 1 }
  let(:title)     { "valid" }
  let(:body)      { "valid" }
  let(:c_at)      { Time.now }
  let(:u_at)      { Time.now }

  it "exists" do
    expect{subject}.not_to raise_error
  end

  context "validations" do
    context "ID with string" do
      let(:id) { 'bad' }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(String\) has invalid type for :id/)
      end
    end

    context "ID with nil" do
      let(:id) { nil }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(NilClass\) has invalid type for :id/)
      end
    end

    context "author_id with String" do
      let(:author_id) { "invalid" }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(String\) has invalid type for :author_id/)
      end
    end

    context "author_id with nil" do
      let(:author_id) { nil }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(NilClass\) has invalid type for :author_id/)
      end
    end

    context "title with integer" do
      let(:title) { 12 }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(Fixnum\) has invalid type for :title/)
      end
    end

    context "title with nil" do
      let(:title) { nil }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(NilClass\) has invalid type for :title/)
      end
    end

    context "body field size contraint" do
      context "body with between 5 and 5k" do
        let(:body) { "a"*5100 }

        it "passes" do
          expect{subject}.not_to raise_error
        end
      end

      context "body with over 5k" do
        let(:body) { "a"*5200 }

        it "fails" do
          expect{subject}.to raise_error(Dry::Struct::Error, /\(String\) has invalid type for :body/)
        end
      end

      context "body with under 5 characters" do
        let(:body) { "a"*2 }

        it "fails" do
          expect{subject}.to raise_error(Dry::Struct::Error, /\(String\) has invalid type for :body/)
        end
      end
    end

    context "body with integer" do
      let(:body) { 12 }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(Fixnum\) has invalid type for :body/)
      end
    end

    context "body with nil" do
      let(:body) { nil }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(NilClass\) has invalid type for :body/)
      end
    end

    context "created_at with integer" do
      let(:c_at) { 12 }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(Fixnum\) has invalid type for :created_at/)
      end
    end

    context "created_at with nil" do
      let(:c_at) { nil }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(NilClass\) has invalid type for :created_at/)
      end
    end

    context "created_at with string" do
      let(:c_at) { 'bad' }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(String\) has invalid type for :created_at/)
      end
    end

    context "updated_at with integer" do
      let(:u_at) { 12 }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(Fixnum\) has invalid type for :updated_at/)
      end
    end

    context "updated_at with nil" do
      let(:u_at) { nil }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(NilClass\) has invalid type for :updated_at/)
      end
    end

    context "updated_at with string" do
      let(:u_at) { 'bad' }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(String\) has invalid type for :updated_at/)
      end
    end
  end
end
