require 'rails_helper'

describe ImageDziJsonFormatter do
  subject{ described_class.new(image, :dzi) }

  let(:relative_filepath) { '/path/to/image.tif' }
  let(:image) { instance_double(Image, width: 1000, height: 1000, relative_filepath: relative_filepath, type: :tif)}
  let(:expected_hash) { {:id=> 'dzi', :width=>1000, :height=>1000, :type=>:dzi, :src=>"http://localhost:3019/images/path/to/image.tif.dzi"} }

  [:width, :height ].each do | field |
    it "##{field} returns image.#{field}" do
      expect(image).to receive(field).and_return(image.send(field))
      expect(subject.send(field)).to eq(image.send(field))
    end
  end

  describe '#type' do
    it "is dzi" do
      expect(subject.type).to eq(:dzi)
    end
  end

  describe '#id' do
    it "is the style cast as a string" do
      expect(subject.id).to eq("dzi")
    end
  end

  describe '#src' do
    it "returns the full url to the image" do
      expect(subject).to receive(:path).and_return('/test/path/to/file.tif.dzi')
      expect(subject.src).to eq("http://localhost:3019/images/test/path/to/file.tif.dzi")
    end
  end

  describe '#path' do
    it "returns the relative path to the image with a .dzi extension" do
      expect(image).to receive(:relative_filepath).and_return(relative_filepath)
      expect(subject.path).to eq(relative_filepath + '.dzi')
    end
  end

  describe '#to_hash' do
    [:width, :height, :id, :type, :src].each do |field|
      it "calls ##{field}" do
        expect(subject).to receive(field)
        subject.to_hash
      end
    end

    it "returns a hash" do
      expect(subject.to_hash).to eq(expected_hash)
    end
  end

  it "returns json" do
    expect(subject.to_json).to eq(expected_hash.to_json)
  end
end
