require 'rails_helper'

describe Image do
  subject { described_class.new(filepath) }
  let(:base_full_filepath) { File.join(Rails.root, 'public/images', path) }
  let(:path) { '/test/000/001/000/002' }
  let(:filename) { 'testimage.jpg' }
  let(:filepath) { File.join(path, filename) }

  it "looks up the width from the file" do
    expect(FastImage).to receive(:size).with(subject.original_filepath).and_return([1200, 1600])
    expect(subject.width).to eq(1200)
  end

  it "looks up the height from the file" do
    expect(FastImage).to receive(:size).with(subject.original_filepath).and_return([1200, 1600])
    expect(subject.height).to eq(1600)
  end

  it "looks up the type from the file" do
    expect(FastImage).to receive(:type).with(subject.original_filepath).and_return(:jpeg)
    expect(subject.type).to eq(:jpeg)
  end

  it "returns the original_filepath" do
    expect(subject.original_filepath).to eq("#{base_full_filepath}/testimage.jpg")
  end

  it "returns the pyramid_filepath" do
    expect(subject.pyramid_filepath).to eq("#{base_full_filepath}/pyramid/testimage.tif")
  end

  describe '#uri_path' do
    it "is the relative path" do
      expect(subject.uri_path).to eq(path)
    end
  end

  describe '#uri_basename' do
    it "is the basename of the file" do
      expect(subject.uri_basename).to eq(filename)
    end
  end

end
