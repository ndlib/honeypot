require 'rails_helper'

describe ImageJsonFormatter do
  subject{ described_class.new(image) }

  let(:image) { instance_double(Image, width: 1000, height: 1000, uri_path: 'path', uri_basename: 'testimage.jpg')}

  [:width, :height, :uri_path, :uri_basename ].each do | field |
    it "calls #{field}" do
      expect(image).to receive(field)
      subject.to_json
    end
  end

  it "returns json" do
    expect(subject.to_json).to eq("{\"width\":1000,\"height\":1000,\"path\":\"path\",\"basename\":\"testimage.jpg\",\"host\":\"localhost\"}")
  end
end
