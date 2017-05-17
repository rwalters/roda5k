require 'spec_helper'
require 'entities/author'

describe Author do
  subject do
    described_class.new(params)
  end

  let(:params) do
    { id: id, first_name: first_name, last_name: last_name, bio: bio, created_at: c_at, updated_at: u_at }
  end

  let(:id)      { 1 }
  let(:first_name)  { "valid" }
  let(:last_name)   { "valid" }
  let(:bio)    { "valid" }
  let(:c_at)    { Time.now }
  let(:u_at)    { Time.now }

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

    context "first_name with integer" do
      let(:first_name) { 12 }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(Fixnum\) has invalid type for :first_name/)
      end
    end

    context "first_name with nil" do
      let(:first_name) { nil }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(NilClass\) has invalid type for :first_name/)
      end
    end

    context "last_name with integer" do
      let(:last_name) { 12 }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(Fixnum\) has invalid type for :last_name/)
      end
    end

    context "last_name with nil" do
      let(:last_name) { nil }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(NilClass\) has invalid type for :last_name/)
      end
    end

    context "bio field size contraint" do
      context "bio with between 5 and 255" do
        let(:bio) { "a"*254}

        it "passes" do
          expect{subject}.not_to raise_error
        end
      end

      context "bio with over 5k" do
        let(:bio) { "a"*256 }

        it "fails" do
          expect{subject}.to raise_error(Dry::Struct::Error, /\(String\) has invalid type for :bio/)
        end
      end

      context "bio with under 5 characters" do
        let(:bio) { "a"*2 }

        it "fails" do
          expect{subject}.to raise_error(Dry::Struct::Error, /\(String\) has invalid type for :bio/)
        end
      end
    end

    context "bio with integer" do
      let(:bio) { 12 }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(Fixnum\) has invalid type for :bio/)
      end
    end

    context "bio with nil" do
      let(:bio) { nil }

      it "raises an error" do
        expect{subject}.to raise_error(Dry::Struct::Error, /\(NilClass\) has invalid type for :bio/)
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
