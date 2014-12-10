require 'rails_helper'

describe ImageJsonFormatter do
  subject{ described_class.new(image) }

  let(:image) { instance_double(Image, width: 1000, height: 1000, filepath: 'path/to/image.jpg')}

  [:width, :height, :filepath ].each do | field |
    it "calls #{field}" do
      expect(image).to receive(field)
      subject.to_json
    end
  end

  it "returns json" do
    expect(subject.to_json).to eq("{\"width\":1000,\"height\":1000,\"path\":\"path/to/image.jpg\"}")
  end
end
