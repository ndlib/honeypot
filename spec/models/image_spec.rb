require 'rails_helper'

describe Image do
  subject { described_class.new(filepath) }
  let(:realpath) { File.join(Rails.root, 'spec/fixtures/testimage.jpg') }
  let(:fakepath) { File.join(Rails.root, 'public/images/test/image.jpg') }
  let(:filepath) { fakepath }

  describe 'existing image' do
    let(:filepath) { realpath }

    describe '#size' do
      it "returns the dimensions" do
        expect(subject.size).to eq ([1200, 1600])
      end
    end

    describe '#exists?' do
      it "returns true" do
        expect(subject.exists?).to be_truthy
      end
    end

    describe '#type' do
      it "is the type of image" do
        expect(subject.type).to eq(:jpeg)
      end
    end
  end

  describe '#width' do
    it "returns the first value from size" do
      expect(subject).to receive(:size).and_return([1200, 1600])
      expect(subject.width).to eq(1200)
    end

    it "returns nil when size is nil" do
      expect(subject.width).to be_nil
    end
  end

  describe '#height' do
    it "returns the second value from size" do
      expect(subject).to receive(:size).and_return([1200, 1600])
      expect(subject.height).to eq(1600)
    end

    it "returns nil when size is nil" do
      expect(subject.height).to be_nil
    end
  end

  describe '#size' do
    it "returns nil when the file isn't present" do
      expect(subject.size).to be_nil
    end
  end

  describe '#type' do
    it "returns nil when the file isn't present" do
      expect(subject.type).to be_nil
    end
  end

  it "returns the filepath" do
    expect(subject.filepath).to eq(filepath)
  end

  describe '#exists?' do
    it "returns false when the file is not present" do
      expect(subject.exists?).to be_falsy
    end
  end

  describe 'self' do
    subject { described_class }
    describe '#find' do
      it "raises an error if the image file is not present" do
        expect{subject.find('fakeimage.jpg')}.to raise_error(described_class::ImageNotFound)
      end

      it "returns an image object if the image file is present" do
        expect_any_instance_of(described_class).to receive(:exists?).and_return(true)
        expect(subject.find('foundimage.jpg')).to be_a_kind_of(described_class)
      end
    end
  end

end
