require 'rails_helper'

describe ImageJsonFormatter do
  subject{ described_class.new(image, :style_name) }


  let(:full_filepath) { File.join(ImageSet.image_root, '/path/to/image.jpg')}
  let(:image) { instance_double(Image, width: 1000, height: 1000, filepath: full_filepath, type: :jpeg)}
  let(:expected_hash) { {:id=> "style_name", :width=>1000, :height=>1000, :type=>:jpeg, :src=>"http://localhost:3019/images/path/to/image.jpg"} }

  [:width, :height, :type ].each do | field |
    it "##{field} returns image.#{field}" do
      expect(image).to receive(field).and_return(image.send(field))
      expect(subject.send(field)).to eq(image.send(field))
    end
  end

  describe '#id' do
    it "is the style cast as a string" do
      expect(subject.id).to eq("style_name")
    end
  end

  describe '#src' do
    it "returns the full url to the image" do
      expect(subject).to receive(:path).and_return('test/path/to/file.gif')
      expect(subject.src).to eq("http://localhost:3019/images/test/path/to/file.gif")
    end
  end

  describe '#path' do
    it "returns the relative path to the image" do
      expect(subject.path).to eq('/path/to/image.jpg')
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
