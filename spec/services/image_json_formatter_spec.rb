require 'rails_helper'

describe ImageJsonFormatter do
  subject{ described_class.new(image, :style) }

  let(:image) { instance_double(Image, width: 1000, height: 1000, filepath: '/path/to/image.jpg', type: :jpeg)}
  let(:expected_hash) { {:id=>"style", :width=>1000, :height=>1000, :type=>:jpeg, :src=>"http://localhost:3019/images/path/to/image.jpg"} }

  [:width, :height, :filepath ].each do | field |
    it "calls #{field}" do
      expect(image).to receive(field)
      subject.to_json
    end
  end

  it "returns a hash" do
    expect(subject.to_hash).to eq(expected_hash)
  end

  it "returns json" do
    expect(subject.to_json).to eq(expected_hash.to_json)
  end
end
